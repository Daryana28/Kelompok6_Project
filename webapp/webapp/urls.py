from django.contrib import admin
from django.urls import path, include
from login import views as login_view
from dashbord import views as dashbord_view
from about import views as about_view

urlpatterns = [
    path('admin/', admin.site.urls),
    path('dashbord/', dashbord_view.dashbord_view, name='home'),  # 🔹 Tambahkan Home View
    path('login/', login_view.login_view, name='login'),
    path('about/', about_view.about_view, name='about_view'),  # 🔹 Perbaiki Nama
    path('about/cctv/', about_view.cctv_feed, name='cctv_feed'),
    path('video_feed/<int:cctv_index>/', about_view.cctv_feed, name='video_feed'),
    path('logout/', login_view.logout_view, name='logout'),
]