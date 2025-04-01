from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from .forms import LoginForm
from django.contrib.auth.decorators import login_required
from django.conf import settings


def login_view(request):
    form = LoginForm()
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('dashbord')  
        
        return render(request, 'login/login_view.html', {'form': form, 'error': 'Invalid credentials'})
    
    login_success = request.GET.get('dashbord')
    return render(request, 'login/login_view.html', {'form': form, 'login_success': login_success})


@login_required(login_url=settings.LOGIN_URL)
def home(request):
    return render(request, 'dashbord/dashbord_view.html')


def logout_view(request):
    logout(request)
    return redirect('login')