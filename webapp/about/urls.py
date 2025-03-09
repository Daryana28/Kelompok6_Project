from django.urls import path
from .views import cctv_feed

urlpatterns = [
    path('cctv/', cctv_feed, name='cctv_feed'),
]
