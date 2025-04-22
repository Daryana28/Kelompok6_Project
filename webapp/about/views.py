import cv2
import torch
import os
import time
from ultralytics import YOLO
from django.shortcuts import render
from django.http import StreamingHttpResponse, HttpResponseServerError
from apd_report.models import Pelanggaran  # Impor model Pelanggaran

# Path ke model YOLOv8
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODEL_PATH = os.path.join(BASE_DIR, 'models', 'helm detection.pt')

# Path untuk menyimpan screenshot
SCREENSHOT_DIR = os.path.join(BASE_DIR, 'apd_report', 'static', 'screenshots')
if not os.path.exists(SCREENSHOT_DIR):
    os.makedirs(SCREENSHOT_DIR)  # Buat folder jika belum ada
print(f"📂 Screenshot directory: {SCREENSHOT_DIR}")

# Variabel untuk cooldown screenshot
last_screenshot_time = 0
COOLDOWN_SECONDS = 5  # Jeda 5 detik antara screenshot

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
    os.path.join(BASE_DIR, 'about', 'static', 'videos', 'new.mp4')
]

def about_view(request):
    """
    Menampilkan halaman about dengan template HTML.
    """
    return render(request, 'about/about_view.html')

def detect_objects(frame):
    """
    Jalankan deteksi YOLOv8 dan tambahkan bounding box ke frame.
    Simpan screenshot dan data ke database untuk deteksi "no-helmet" terjauh.
    Tambahkan cooldown agar screenshot hanya diambil setiap COOLDOWN_SECONDS detik.
    """
    global last_screenshot_time  # Gunakan variabel global

    print("🔍 YOLO Processing Frame...")  # Debugging
    results = model(frame, stream=True, conf=0.5)  # Optimasi: confidence score ≥ 50%
    
    smallest_area = float('inf')  # Inisialisasi luas terkecil dengan nilai tak hingga
    furthest_no_helmet_frame = None  # Frame untuk deteksi terjauh
    furthest_confidence = None  # Skor confidence untuk deteksi terjauh
    no_helmet_detected = False  # Flag untuk deteksi "no-helmet"

    # Salin frame untuk dimodifikasi (menambahkan bounding box)
    annotated_frame = frame.copy()

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

                # Gambar bounding box dan label pada frame yang ditampilkan
                cv2.rectangle(annotated_frame, (x1, y1), (x2, y2), color, 2)
                cv2.putText(annotated_frame, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

                # Jika "no-helmet" terdeteksi, hitung luas bounding box
                if cls == 7:  # Index 7 untuk "no-helmet"
                    no_helmet_detected = True
                    area = (x2 - x1) * (y2 - y1)  # Hitung luas bounding box
                    print(f"📏 Luas bounding box 'no-helmet': {area}")

                    # Simpan deteksi dengan luas terkecil (paling jauh)
                    if area < smallest_area:
                        smallest_area = area
                        furthest_no_helmet_frame = annotated_frame.copy()  # Simpan frame dengan deteksi terjauh
                        furthest_confidence = score  # Simpan skor confidence

    # Simpan screenshot dan data ke database jika ada deteksi "no-helmet" terjauh
    if no_helmet_detected and furthest_no_helmet_frame is not None:
        current_time = time.time()
        if current_time - last_screenshot_time >= COOLDOWN_SECONDS:
            timestamp = time.strftime("%Y%m%d-%H%M%S")  # Format: YYYYMMDD-HHMMSS
            screenshot_path = os.path.join(SCREENSHOT_DIR, f"no_helmet_furthest_{timestamp}.jpg")
            cv2.imwrite(screenshot_path, furthest_no_helmet_frame)
            last_screenshot_time = current_time
            print(f"📸 Screenshot 'no-helmet' terjauh disimpan: {screenshot_path}")

            # Simpan ke database
            Pelanggaran.objects.create(
                jenis_pelanggaran="No Helmet",
                screenshot_path=screenshot_path,
                confidence=furthest_confidence,
            )
            print(f"💾 Data pelanggaran disimpan ke database: {screenshot_path}")

        else:
            print(f"⏳ Cooldown: Menunggu {COOLDOWN_SECONDS - (current_time - last_screenshot_time):.2f} detik untuk screenshot berikutnya.")

    return annotated_frame

def video_stream(video_index):
    """
    Streaming video lokal dengan bounding box YOLOv8 dan debugging.
    """
    if video_index >= len(VIDEO_FILES) or video_index < 0:
        print(f"⚠️ Indeks video tidak valid: {video_index}")
        return None

    # Debugging path video
    print(f"📂 Path video: {VIDEO_FILES[video_index]}")
    if not os.path.exists(VIDEO_FILES[video_index]):
        print(f"❌ File video tidak ditemukan: {VIDEO_FILES[video_index]}")
        return None

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
    


    
