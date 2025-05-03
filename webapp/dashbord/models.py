# apd_report/models.py
from django.db import models

class Pelanggaran(models.Model):
    waktu = models.DateTimeField(auto_now_add=True)
    lokasi = models.CharField(max_length=255, default="Lokasi Tidak Diketahui")
    jenis_pelanggaran = models.CharField(max_length=255)
    tindakan = models.TextField(default="Peringatan")
    screenshot_path = models.CharField(max_length=255, blank=True, null=True)  # Path ke screenshot
    confidence = models.FloatField(blank=True, null=True)  # Skor confidence dari YOLOv8

    def __str__(self):
        return f"{self.jenis_pelanggaran} at {self.lokasi}"