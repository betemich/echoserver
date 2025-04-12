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
    path('profile/<str:login>/', views.profile, name='profile'),
    path('add_to_cart/<int:pk>', views.add_to_cart, name='add_to_cart'),
    path('cart', views.cart, name='cart'),
    path('remove_from_cart/<int:pk>', views.remove_from_cart, name='remove_from_cart'),
    path('checkout', views.checkout, name='checkout'),
    path('orders', views.orders, name='orders'),
    path('order/<int:pk>', views.order_detail, name='order_detail'),
    path('validate_field/', views.validate_field, name='validate_field')
]