from django.shortcuts import render
from apd_report.models import Pelanggaran  # pastikan import dari app tempat model Pelanggaran berada
from django.db.models import Count
import json

def dashboard_view(request):
    # Hitung jumlah pelanggaran per jenis
    data_by_jenis = Pelanggaran.objects.values('jenis_pelanggaran').annotate(count=Count('id'))

    chart_labels = [item['jenis_pelanggaran'] for item in data_by_jenis]
    chart_data = [item['count'] for item in data_by_jenis]

    context = {
        'chart_labels': json.dumps(chart_labels),
        'chart_data': json.dumps(chart_data),
    }
    return render(request, 'dashbord/dashbord_view.html', context)