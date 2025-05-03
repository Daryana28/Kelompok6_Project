# apd_report/views.py
from django.shortcuts import render
from .models import Pelanggaran

def laporan(request):
    pelanggaran = Pelanggaran.objects.all().order_by('-waktu')
    print("Data pelanggaran:", pelanggaran)  # Debugging untuk memastikan data ada
    return render(request, 'apd_report/laporan.html', {'pelanggaran': pelanggaran})


