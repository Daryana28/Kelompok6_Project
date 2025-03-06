from django.shortcuts import render

# Create your views here.
def about_view(request):
    context = {}  # Define the context variable
    return render(request, 'about/about_view.html', context)