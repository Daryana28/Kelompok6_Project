# apd_report/urls.py
from django.urls import path
from .views import laporan  # Mengimpor tampilan laporan_apd dari views.py
from . import views



urlpatterns = [
    path('', laporan, name='laporan_apd'),
    path('laporan/', laporan, name='laporan_apd'),# Rute untuk laporan APD
    path('', views.laporan, name='apd_report'),
    path('' ,laporan , name='laporan_apd' ),

]
