from django.urls import path
from .views import about_view, cctv_feed

urlpatterns = [
    path('', about_view, name='about_view'),  # Tampilkan about_view.html
    path('cctv/', cctv_feed, name='cctv_feed'),  # Streaming CCTV
    path('video_feed/<int:cctv_index>/', cctv_feed, name='video_feed'),  # Streaming untuk index tertentu
]