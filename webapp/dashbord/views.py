from django.shortcuts import render

# Create your views here.
def dashbord_view(request):
    context = {}  # Define the context variable
    return render(request, 'dashbord/dashbord_view.html', context)