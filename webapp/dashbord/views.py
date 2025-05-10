from django.shortcuts import render
from apd_report.models import Pelanggaran  # pastikan import dari app tempat model Pelanggaran berada
from django.db.models import Count
import json
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

def dashboard_view(request):

    # Hitung total pelanggaran
    total_pelanggaran = Pelanggaran.objects.count()
    logger.info(f"Total pelanggaran: {total_pelanggaran}")


    # Hitung jumlah pelanggaran per jenis
    data_by_jenis = Pelanggaran.objects.values('jenis_pelanggaran').annotate(count=Count('id'))

    chart_labels = [item['jenis_pelanggaran'] for item in data_by_jenis]
    chart_data = [item['count'] for item in data_by_jenis]

# Data untuk chart (opsional, jika Anda ingin menambahkan statistik bulanan)
    
    chart_labels = [str(month) for month in range(1, 13)]
    chart_data = [0] * 12
    monthly_data = (
        Pelanggaran.objects
        .extra({'month': "EXTRACT(MONTH FROM waktu)"})
        .values('month')
        .annotate(total=Count('id'))
        .order_by('month')
    )
    for item in monthly_data:
        month = int(item['month']) - 1
        if 0 <= month < 12:
            chart_data[month] = item['total']

 # Data untuk chart mingguan (per minggu dalam setahun)
    chart_labels_week = [f"Minggu-{week}" for week in range(1, 53)]  # 52 minggu dalam setahun
    chart_data_week = [0] * 52
    weekly_data = (
        Pelanggaran.objects
        .extra({'week': "EXTRACT(WEEK FROM waktu)"})
        .values('week')
        .annotate(total=Count('id'))
        .order_by('week')
    )
    logger.info(f"Weekly data raw: {list(weekly_data)}")
    for item in weekly_data:
        week = int(item['week']) - 1  # Minggu dimulai dari 1, jadi kita kurangi 1 untuk index array
        if 0 <= week < 52:
            chart_data_week[week] = item['total']
    logger.info(f"Chart data (week): {chart_data_week}")

    context = {
        'total_pelanggaran': total_pelanggaran,
        'chart_labels': json.dumps(chart_labels),
        'chart_data': json.dumps(chart_data),
        'chart_labels_week': json.dumps(chart_labels_week),
        'chart_data_week': json.dumps(chart_data_week),
        'chart_labels_jenis': json.dumps(chart_labels),
        'chart_data_jenis': json.dumps(chart_data),
        'chart_labels_month': json.dumps(chart_labels),
       
        


    }
    return render(request, 'dashbord/dashbord_view.html', context)

