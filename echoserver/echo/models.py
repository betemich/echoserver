# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin

class Book(models.Model):
    title = models.CharField(max_length=500)
    author = models.CharField(max_length=500)
    cost = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'book'
    
    def __str__(self):
        return self.title

class User(AbstractBaseUser, PermissionsMixin):
    login = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=256)
    mail = models.CharField(max_length=100)
    user_name = models.CharField(max_length=100)
    user_role = models.CharField(max_length=100, default='user')
    last_login = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'login'
    REQUIRED_FIELDS = ['mail', 'user_name']

    class Meta:
        managed = False
        db_table = 'users'

    def __str__(self):
        return self.login
    
class Order(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    total_price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='user_order')

    class Meta:
        managed = False
        db_table = 'orders'

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='order_items')
    book = models.ForeignKey(Book, on_delete=models.CASCADE, related_name='item_book')
    quantity = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'order_item'
