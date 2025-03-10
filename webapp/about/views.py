import cv2
import torch
import numpy as np
import os
import time  # Tambahkan untuk mengatur FPS
from ultralytics import YOLO
from django.shortcuts import render
from django.http import StreamingHttpResponse, HttpResponseServerError

# Path ke model YOLOv8
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODEL_PATH = os.path.join(BASE_DIR, 'models', 'helm detection.pt')

# Cek apakah model tersedia
if not os.path.exists(MODEL_PATH):
    raise FileNotFoundError(f"⚠️ Model tidak ditemukan di {MODEL_PATH}")

try:
    # Load model YOLOv8
    model = YOLO(MODEL_PATH)
    print("✅ Model YOLOv8 berhasil dimuat.")
    
    # Dapatkan daftar class dalam model
    class_names = model.names
    print("📌 Class dalam model:", class_names)
except Exception as e:
    raise RuntimeError(f"❌ Gagal memuat model YOLOv8: {e}")

# Hanya gunakan class "helmet" (index 3) dan "no-helmet" (index 7)
VALID_CLASSES = {3: "helmet", 7: "no-helmet"}
COLORS = {3: (0, 255, 0), 7: (0, 0, 255)}  # Hijau untuk helmet, Merah untuk no-helmet

# URL CCTV
CCTV_URLS = [
    "https://cctvjss.jogjakota.go.id/malioboro/Malioboro_3_Depan_Dispar.stream/chunklist_w1244613808.m3u8",
    "https://cctvjss.jogjakota.go.id/malioboro/Malioboro_21_Utara_Inna_Malioboro.stream/chunklist_w251511755.m3u8"
]

def about_view(request):
    """
    Menampilkan halaman about dengan template HTML.
    """
    return render(request, 'about/about_view.html')

def detect_objects(frame):
    """
    Jalankan deteksi YOLOv8 dan tambahkan bounding box ke frame.
    """
    print("🔍 YOLO Processing Frame...")  # Debugging
    results = model(frame, stream=True, conf=0.5)  # Optimasi: confidence score ≥ 50%

    for result in results:
        for box in result.boxes:
            if box.xyxy is None or len(box.xyxy) == 0:
                print("⚠️ Tidak ada deteksi pada frame ini.")
                continue

            x1, y1, x2, y2, score, cls = box.xyxy[0].tolist() + [box.conf[0].item(), int(box.cls.item())]
            x1, y1, x2, y2 = map(int, [x1, y1, x2, y2])

            print(f"🎯 Deteksi: {cls} - {VALID_CLASSES.get(cls, 'Unknown')} (Score: {score:.2f})")

            if cls in VALID_CLASSES:
                label = f"{VALID_CLASSES[cls]}: {score:.2f}"
                color = COLORS[cls]

                # Gambar bounding box dan label
                cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)
                cv2.putText(frame, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)
    return frame

def cctv_stream(cctv_index):
    """
    Streaming CCTV dengan bounding box YOLOv8 dan debugging.
    """
    if cctv_index >= len(CCTV_URLS) or cctv_index < 0:
        print("⚠️ Indeks CCTV tidak valid.")
        return None  

    cap = cv2.VideoCapture(CCTV_URLS[cctv_index], cv2.CAP_FFMPEG)
    cap.set(cv2.CAP_PROP_BUFFERSIZE, 2)  # Optimasi buffer

    if not cap.isOpened():
        print("❌ Gagal membuka streaming CCTV")
        return None

    try:
        while cap.isOpened():
            ret, frame = cap.read()
            if not ret:
                print("⚠️ Gagal membaca frame dari CCTV")
                break

            print("✅ Frame berhasil diambil!")  # Debugging
            frame = cv2.resize(frame, (960, 540), interpolation=cv2.INTER_CUBIC)  # 🔹 Naikkan resolusi agar lebih jelas
            frame = detect_objects(frame)  # Jalankan YOLO
            _, jpeg = cv2.imencode('.jpg', frame, [cv2.IMWRITE_JPEG_QUALITY, 80])  # 🔹 Naikkan kualitas gambar
            frame_bytes = jpeg.tobytes()

            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n')

            time.sleep(0.05)  # Batasi ke ~20 FPS untuk mengurangi lag
    finally:
        cap.release()

def cctv_feed(request, cctv_index):
    """
    Endpoint untuk streaming video dengan deteksi objek YOLOv8.
    """
    try:
        stream = cctv_stream(int(cctv_index))
        if stream is None:
            return HttpResponseServerError("Gagal membuka CCTV stream.")
        
        return StreamingHttpResponse(stream, content_type='multipart/x-mixed-replace; boundary=frame')
    except Exception as e:
        print(f"❌ ERROR: {e}")
        return HttpResponseServerError("Terjadi kesalahan pada server.")
