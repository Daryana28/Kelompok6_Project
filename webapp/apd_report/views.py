# apd_report/views.py
from django.shortcuts import render
from .models import Pelanggaran  # Mengimpor model dari file models.py di folder yang sama

def laporan_apd(request):
    pelanggaran = Pelanggaran.objects.all()
    return render(request, 'apd_report/laporan.html', {'pelanggaran': pelanggaran})
