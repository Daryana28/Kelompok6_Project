from django.shortcuts import render

# Create your views here.
def about_view(request):
    context = {}  # Define the context variable
    return render(request, 'about/about_view.html', context)


import cv2
from django.http import StreamingHttpResponse

M3U8_URL = "https://cctvjss.jogjakota.go.id/malioboro/Malioboro_3_Depan_Dispar.stream/chunklist_w1244613808.m3u8"  # Ganti dengan URL M3U8

def cctv_stream():
    cap = cv2.VideoCapture(M3U8_URL)  # Buka stream M3U8
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break  # Stop jika tidak bisa membaca frame
        _, jpeg = cv2.imencode('.jpg', frame)  # Encode frame ke JPEG
        frame = jpeg.tobytes()
        
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')

    cap.release()

def cctv_feed(request):
    return StreamingHttpResponse(cctv_stream(), content_type='multipart/x-mixed-replace; boundary=frame')
