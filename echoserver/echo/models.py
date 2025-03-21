# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models

class Book(models.Model):
    title = models.CharField(max_length=500)
    author = models.CharField(max_length=500)
    cost = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'book'
    
    def __str__(self):
        return self.title

class User(models.Model):
    login = models.CharField(max_length=100)
    passw = models.CharField(max_length=100)
    mail = models.CharField(max_length=100)
    user_name = models.CharField(max_length=100)
    user_role = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'users'

    def __str__(self):
        return self.login