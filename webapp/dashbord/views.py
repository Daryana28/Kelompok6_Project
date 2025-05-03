from django.shortcuts import render
from apd_report.models import Pelanggaran
from django.utils import timezone
from .models import Pelanggaran

import json
# Create your views here.
def dashbord_view(request):
    context = {}  # Define the context variable
    return render(request, 'dashbord/dashbord_view.html', context)

def dashboard_view(request):
    all_pelanggaran = Pelanggaran.objects.all()
    print("Total data di database:", all_pelanggaran.count())

    total_pelanggaran = all_pelanggaran.count()
    if total_pelanggaran >= 1000:
        total_pelanggaran_formatted = f"{total_pelanggaran / 1000:.1f}K"
    else:
        total_pelanggaran_formatted = str(total_pelanggaran)

    if all_pelanggaran.exists():
        min_date = all_pelanggaran.order_by('waktu').first().waktu
        max_date = all_pelanggaran.order_by('-waktu').first().waktu
        print("Min date:", min_date, "Max date:", max_date)
    else:
        min_date = timezone.now()
        max_date = timezone.now()
        print("Tidak ada data, menggunakan default:", min_date, max_date)

    start_date = request.GET.get('start_date', min_date.strftime("%Y-%m-%d"))
    end_date = request.GET.get('end_date', max_date.strftime("%Y-%m-%d"))

    try:
        start_date = timezone.datetime.strptime(start_date, "%Y-%m-%d")
        end_date = timezone.datetime.strptime(end_date, "%Y-%m-%d")
        print("Rentang tanggal:", start_date, "hingga", end_date)
    except ValueError as e:
        print("Error parsing tanggal:", e)
        start_date = min_date
        end_date = max_date

    pelanggaran_list = Pelanggaran.objects.filter(waktu__range=[start_date, end_date])
    print("Data setelah filter:", pelanggaran_list.count())

    no_helmet_data = [0] * 12
    peringatan_data = [0] * 12
    total_pelanggaran_data = [0] * 12

    for item in pelanggaran_list:
        month_index = item.waktu.month - 1
        if "No Helmet" in item.jenis_pelanggaran:
            no_helmet_data[month_index] += 1
        elif item.jenis_pelanggaran == "Peringatan":
            peringatan_data[month_index] += 1
        total_pelanggaran_data[month_index] += 1

    context = {
        'pelanggaran': pelanggaran_list,
        'user': request.user,
        'no_helmet_data': json.dumps(no_helmet_data),  # Konversi ke JSON
        'peringatan_data': json.dumps(peringatan_data),  # Konversi ke JSON
        'total_pelanggaran_data': json.dumps(total_pelanggaran_data),  # Konversi ke JSON
        'min_date': min_date.strftime("%d %b %Y"),
        'max_date': max_date.strftime("%d %b %Y"),
        'total_pelanggaran': total_pelanggaran_formatted,
    }
    return render(request, 'dashbord/dashbord_view.html', context)