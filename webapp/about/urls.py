from django.urls import path
from .views import about_view, video_feed  # Make sure you import video_feed, not cctv_feed

urlpatterns = [
    path('', about_view, name='about_view'),  # Tampilkan about_view.html
    path('cctv/', about_view, name='cctv_feed'),  # If you want to keep cctv endpoint here
    path('video_feed/<int:video_index>/', video_feed, name='video_feed'),  # Streaming untuk index tertentu
]