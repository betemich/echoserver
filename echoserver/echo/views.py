from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.core.paginator import Paginator
from .models import Book
from .models import User
from django.contrib.auth import authenticate, login, logout
from .forms import BookForm
from .forms import UserForm
from .forms import RegistrationForm
from django.contrib.auth.hashers import make_password

def book_list(request):
    books = Book.objects.all().order_by('title')
    paginator = Paginator(books, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'books/book_list.html', {
        'page_obj': page_obj,
        'user': request.user
    })


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
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.set_password(form.cleaned_data['password'])
            user.save()
            return redirect('login')
    else:
        form = RegistrationForm()
    return render(request, 'books/registration.html', {
        'form': form
    })

def logn(request):
    if request.method == 'POST':
        user_login = request.POST['user_login']
        password = request.POST['password']
        user = authenticate(request, username=user_login, password=password)
        if user is not None:
            login(request, user)
            return redirect('book_list')
        return render(request, 'books/login.html', {
            'error': "Неверный логин или пароль"
        })
    return render(request, 'books/login.html')
        
def lgout(request):
    logout(request)
    return redirect('book_list')

