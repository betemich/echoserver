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
    
class ChangePasswordForm(forms.ModelForm):
    new_password = forms.CharField(widget=forms.PasswordInput())
    confirm_password = forms.CharField(widget=forms.PasswordInput())
    class Meta:
        model = User
        fields = ['password']

    def clean():
        cleaned_data = super().clean()
        new_password = cleaned_data.get('new_password')
        confirm_password = cleaned_data.get('confirm_password')
        if new_password and confirm_password and new_password != confirm_password:
            raise forms.ValidationError("Пароли не совпадают")
        return cleaned_data
    

