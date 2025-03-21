from django import forms
from .models import Book
from .models import User

class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'cost']

class UserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['login', 'passw', 'mail', 'user_name', 'user_role']