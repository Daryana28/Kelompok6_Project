# apd_report/urls.py
from django.urls import path
from .views import laporan_apd  # Mengimpor tampilan laporan_apd dari views.py
from . import views

urlpatterns = [
    path('', laporan_apd, name='laporan_apd'),
    path('laporan/', laporan_apd, name='laporan_apd'),# Rute untuk laporan APD
    path('', views.laporan_apd, name='apd_report'),
]
