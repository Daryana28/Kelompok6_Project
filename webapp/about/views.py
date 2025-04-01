import cv2
import torch
import os
import time
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
    # Load model YOLOv8 dengan perangkat GPU jika tersedia
    device = 'cuda' if torch.cuda.is_available() else 'cpu'
    model = YOLO(MODEL_PATH).to(device)
    print("✅ Model YOLOv8 berhasil dimuat.")
    
    # Dapatkan daftar class dalam model
    class_names = model.names
    print("📌 Class dalam model:", class_names)
except Exception as e:
    raise RuntimeError(f"❌ Gagal memuat model YOLOv8: {e}")

# Hanya gunakan class "helmet" (index 3) dan "no-helmet" (index 7)
VALID_CLASSES = {3: "helmet", 7: "no-helmet"}
COLORS = {3: (0, 255, 0), 7: (0, 0, 255)}  # Hijau untuk helmet, Merah untuk no-helmet

# Update to dynamically find video files
VIDEO_FILES = [
    os.path.join(BASE_DIR, 'about', 'static', 'videos', 'motor.mp4'),
    os.path.join(BASE_DIR, 'about', 'static', 'videos', 'neww.mp4')
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
def video_stream(video_index):
    """
    Streaming video lokal dengan bounding box YOLOv8 dan debugging.
    """
    if video_index >= len(VIDEO_FILES) or video_index < 0:
        print(f"⚠️ Indeks video tidak valid: {video_index}")
        return None  # Pastikan video index yang diteruskan valid

    # Menampilkan video yang dipilih
    print(f"📽️ Memilih video dengan index: {video_index} - {VIDEO_FILES[video_index]}")

    cap = cv2.VideoCapture(VIDEO_FILES[video_index])

    if not cap.isOpened():
        print("❌ Gagal membuka video lokal")
        return None

    try:
        frame_buffer = []  # Buffer untuk menyimpan frame
        while cap.isOpened():
            ret, frame = cap.read()
            if not ret:
                print("⚠️ Gagal membaca frame dari video")
                break

            print("✅ Frame berhasil diambil!")  # Debugging
            
            # Mengatur ukuran dan kualitas frame
            frame = cv2.resize(frame, (1280, 720), interpolation=cv2.INTER_CUBIC)  # Resolusi tinggi
            
            # Menjalankan deteksi objek YOLO
            frame = detect_objects(frame)  # Jalankan YOLO
            
            # Mengompresi frame menjadi JPEG dengan kualitas yang lebih tinggi
            _, jpeg = cv2.imencode('.jpg', frame, [cv2.IMWRITE_JPEG_QUALITY, 90])  # Kualitas gambar
            frame_bytes = jpeg.tobytes()

            # Menyimpan frame dalam buffer untuk mempermudah aliran video
            frame_buffer.append(frame_bytes)

            if len(frame_buffer) > 3:  # Batasi ukuran buffer hanya 3 frame
                # Kirimkan frame pertama dari buffer
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame_buffer.pop(0) + b'\r\n')

    finally:
        cap.release()

def video_feed(request, video_index):
    """
    Endpoint untuk streaming video lokal dengan deteksi objek YOLOv8.
    """
    try:
        stream = video_stream(int(video_index))
        if stream is None:
            return HttpResponseServerError("Gagal membuka video lokal.")
        
        return StreamingHttpResponse(stream, content_type='multipart/x-mixed-replace; boundary=frame')
    except Exception as e:
        print(f"❌ ERROR: {e}")
        return HttpResponseServerError("Terjadi kesalahan pada server.")