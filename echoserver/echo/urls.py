from django.urls import path

from . import views

urlpatterns = [
    path('', views.book_list, name='book_list'),
    path('create/', views.book_create, name='book_create'),
    path('update/<int:pk>/', views.book_update, name='book_update'),
    path('delete/<int:pk>/', views.book_delete, name='book_delete'),
    path('register/', views.registration, name='registration'),
    path('login/', views.logn, name='login'),
    path('logout/', views.lgout, name='logout'),
    path('profile/<str:login>/', views.profile, name='profile')
]