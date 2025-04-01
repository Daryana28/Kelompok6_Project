# apd_report/models.py
from django.db import models

class Pelanggaran(models.Model):
    waktu = models.DateTimeField(auto_now_add=True)
    lokasi = models.CharField(max_length=255)
    jenis_pelanggaran = models.CharField(max_length=255)
    tindakan = models.TextField()

    def __str__(self):
        return f"{self.jenis_pelanggaran} at {self.lokasi}"
