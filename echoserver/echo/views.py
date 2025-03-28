from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.core.paginator import Paginator
from .models import Book
from .models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages
from .forms import BookForm
from .forms import ChangeProfileForm
from .forms import RegistrationForm
from .forms import ChangePasswordForm
from uuid import uuid4
import json

def book_list(request):
    books = Book.objects.all().order_by('title')
    paginator = Paginator(books, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'books/book_list.html', {
        'page_obj': page_obj,
        'user': request.user
    })

@login_required
def book_create(request):
    if request.method == 'POST':
        form = BookForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('book_list')
    else:
        form = BookForm()
    return render(request, 'books/book_create.html', {'form': form})

@login_required
def book_update(request, pk):
    if request.user.user_role == "user":
        messages.error(request, "Вы не можете обновлять книги")
        return redirect('book_list')
    
    book = get_object_or_404(Book, pk=pk)
    if request.method == 'POST':
        form = BookForm(request.POST, instance=book)
        if form.is_valid():
            form.save()
            return redirect('book_list')
    else:
        form = BookForm(instance=book)
    return render(request, 'books/book_update.html', {'form': form})
    
@login_required
def book_delete(request, pk):
    if request.user.user_role == "user":
        messages.error(request, "Вы не можете удалять книги")
        return redirect('book_list')
    
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

@login_required
def profile(request, login):
    user = get_object_or_404(User, login=login)

    if request.user.user_role != 'admin' and user.login != request.user.login:
        messages.warning(request, "Вы можете просматривать только свой профиль")
        return redirect('profile', login=request.user.login)
    
    edit_mode = request.GET.get('edit')
    change_password_mode = request.GET.get('change_password')
    if request.method == 'POST' and edit_mode == 'true':
        user_form = ChangeProfileForm(request.POST, instance=user)
        if user_form.is_valid():
            user_form.save()
            messages.success(request, "Профиль успешно обновлен")
            return redirect('profile', login=request.user.login)
    else:
        user_form = ChangeProfileForm(instance=user)

    if request.method == 'POST' and change_password_mode == 'true':
        pass_form = ChangePasswordForm(user, request.POST)
        if pass_form.is_valid():
            user.set_password(pass_form.cleaned_data['new_password'])
            user.save()
            logout(request)
            messages.success(request, "Пароль успешно изменен")
            return redirect('login')
    else:
        pass_form = ChangePasswordForm(user)

    return render(request, 'books/profile.html', {
        'user': user,
        'form': user_form,
        'password_form': pass_form,
        'edit_mode': edit_mode,
        'change_password_mode': change_password_mode
    })

@login_required
def add_to_cart(request, pk):
    book = Book.objects.get(pk=pk)
    cart_cookie = request.COOKIES.get('cart', '{}')
    try:
        cart = json.loads(cart_cookie)
    except json.JSONDecodeError:
        cart = {}
    
    book_id_str = str(pk)
    if book_id_str in cart:
        cart[book_id_str] += 1
    else:
        cart[book_id_str] = 1

    response = redirect('book_list')
    response.set_cookie(
        'cart',
        json.dumps(cart),
        max_age=31536000
    )

    messages.success(request, f"Книга \"{book.title}\" успешно добавлена в корзину")
    return response

@login_required
def cart(request):
    cart_cookie = request.COOKIES.get('cart', '{}')
    try:
        cart = json.loads(cart_cookie)
    except json.JSONDecodeError:
        cart = {}

    cart_items = []
    overall_price = 0
    for book_id, quantity in cart.items():
        try:
            book = Book.objects.get(pk=book_id)
            cart_items.append({
                'book': book,
                'quantity': quantity
            })
            overall_price += quantity * book.cost
        except Book.DoesNotExist:
            continue

    return render(request, 'books/cart.html', {
        'cart_items': cart_items,
        'overall_price': overall_price
    })

@login_required
def remove_from_cart(request, pk):
    book = Book.objects.get(pk=pk)
    cart_cookie = request.COOKIES.get('cart', '{}')
    try:
        cart = json.loads(cart_cookie)
    except json.JSONDecodeError:
        cart = {}

    str_pk = str(pk)
    if str_pk in cart and cart[str_pk] > 1:
        cart[str_pk] -= 1
    elif str_pk in cart:
        del cart[str_pk]

    responce = redirect('cart')
    responce.set_cookie(
        'cart',
        json.dumps(cart),
        max_age=31536000
    )

    messages.success(request, f"Книга \"{book.title}\" успешно удалена из корзины")
    return responce
    
