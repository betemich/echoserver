from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.core.paginator import Paginator
from .models import Book
from .models import User
from django.contrib.auth import authenticate, login
from .forms import BookForm
from .forms import UserForm

def book_list(request):
    books = Book.objects.all().order_by('title')
    paginator = Paginator(books, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'books/book_list.html', {'page_obj': page_obj})

def book_create(request):
    if request.method == 'POST':
        form = BookForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('book_list')
    else:
        form = BookForm()
    return render(request, 'books/book_create.html', {'form': form})

def book_update(request, pk):
    book = get_object_or_404(Book, pk=pk)
    if request.method == 'POST':
        form = BookForm(request.POST, instance=book)
        if form.is_valid():
            form.save()
            return redirect('book_list')
    else:
        form = BookForm(instance=book)
    return render(request, 'books/book_update.html', {'form': form})
    
def book_delete(request, pk):
    book = get_object_or_404(Book, pk=pk)
    if request.method == 'POST':
        book.delete()
        return redirect('book_list')
    return render(request, 'books/book_delete.html', {'book': book})

def registration(request):
    if request.method == 'POST':
        login = request.POST['login']
        user_name = request.POST['user_name']
        mail = request.POST['mail']
        user_role = 'user'
        passw = request.POST['passw']
        confirm_passw = request.POST['confirm_passw']
        if passw != confirm_passw:
            return render(request, 'books/registration.html', {'error': "Пароли не совпадают"})

        exists = User.objects.filter(mail=mail)
        if exists:
            return render(request, 'books/registration.html', {'error': "Эта почта уже зарегистрирована"})
        
        exists = User.objects.filter(login=login)
        if exists:
            return render(request, 'books/registration.html', {'error': "Логин занят"})

        form = User(
            login=login,
            passw=passw,
            mail=mail,
            user_name=user_name,
            user_role=user_role
        )
        form.save()
        return redirect('book_list')
    return render(request, 'books/registration.html')

def logn(request):
    if request.method == 'POST':
        user_login = request.POST['user_login']
        passw = request.POST['passw']

        correct = authenticate(request, username=user_login, password=passw)
        if correct is not None:
            login(request, correct)
            if User.objects.filter(user_role='user'):
                return redirect('book_list_user')
            elif User.objects.filter(user_role='admin'):
                return redirect('book_list_admin')
        else:
            return render(request, 'books/login.html', {'error': "Неверный логин или пароль"})
    return render(request, 'books/login.html')
        
