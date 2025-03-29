from django import forms
from .models import Book
from .models import User
from django.contrib.auth.hashers import check_password

class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'cost']

class UserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['login', 'password', 'mail', 'user_name', 'user_role']

class RegistrationForm(forms.ModelForm):
    confirm_password = forms.CharField(widget=forms.PasswordInput())

    class Meta:
        model = User
        fields = ['login', 'password', 'mail', 'user_name']
        widgets = {'password': forms.PasswordInput()}

    def clean_login(self):
        login = self.cleaned_data['login']
        if User.objects.filter(login=login).exists():
            raise forms.ValidationError("Логин занят")
        return login
    
    def clean_mail(self):
        mail = self.cleaned_data['mail']
        if User.objects.filter(mail=mail).exists():
            raise forms.ValidationError("Почта уже зарегистрирована")
        return mail
    
    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get('password')
        confirm_password = cleaned_data.get('confirm_password')
        if password and confirm_password and password != confirm_password:
            raise forms.ValidationError("Пароли не совпадают")
        return cleaned_data
    
class ChangeProfileForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['login', 'mail', 'user_name']

    def clean_mail(self):
        mail = self.cleaned_data['mail']
        if User.objects.filter(mail=mail).exists():
            raise forms.ValidationError("Почта уже зарегистрирована")
        return mail
    
class ChangePasswordForm(forms.Form):
    new_password = forms.CharField(widget=forms.PasswordInput())
    confirm_new_password = forms.CharField(widget=forms.PasswordInput())
    old_password = forms.CharField(widget=forms.PasswordInput())

    def __init__(self, user, *args, **kwargs):
        self.user = user
        super().__init__(*args, **kwargs)

    def clean_old(self):
        old_pass = self.cleaned_data('old_password')
        if not check_password(old_pass, self.user.password):
            raise forms.ValidationError("Неверный старый пароль")
        return old_pass

    def clean(self):
        cleaned_data = super().clean()
        new_password = cleaned_data.get('new_password')
        confirm_new_password = cleaned_data.get('confirm_new_password')
        if new_password and confirm_new_password and new_password != confirm_new_password:
            raise forms.ValidationError("Пароли не совпадают")
        return cleaned_data
    

    

