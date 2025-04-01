from django.contrib import admin
from django.urls import path, include
from login import views as login_view
from dashbord import views as dashbord_view
from about import views as about_view
from apd_report import urls as apd_report_urls 
from django.shortcuts import redirect 

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', lambda request: redirect('login')),  
    path('login/', login_view.login_view, name='login'),
    path('dashbord/', dashbord_view.dashbord_view, name='dashbord'),
    path('about/', about_view.about_view, name='about_view'),  # Halaman About
    path('video_feed/<int:video_index>/', about_view.video_feed, name='video_feed'),
    path('apd_report/', include(apd_report_urls)),# Video Feed
    path('logout/', login_view.logout_view, name='logout'),
    path('apd/', include('apd_report.urls')),
]