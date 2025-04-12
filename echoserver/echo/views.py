from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.core.paginator import Paginator
from .models import Book
from .models import User
from .models import Order
from .models import OrderItem
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import BookForm
from .forms import ChangeProfileForm
from .forms import RegistrationForm
from .forms import ChangePasswordForm
from django.http import JsonResponse
import json
import re
from django.template.loader import render_to_string
from abc import ABC, abstractmethod

class BookFilter(ABC):
    @abstractmethod
    def add_filter(self):
        pass

class CostFilterASC(BookFilter):
    def add_filter(self, queryset):
        queryset.append('cost')
        return queryset
    
class CostFilterDESC(BookFilter):
    def add_filter(self, queryset):
        queryset.append('-cost')
        return queryset
    
class TitleFilterASC(BookFilter):
    def add_filter(self, queryset):
        queryset.append('title')
        return queryset
    
class TitleFilterDESC(BookFilter):
    def add_filter(self, queryset):
        queryset.append('-title')
        return queryset
    
FILTERS = {
    'costASC': CostFilterASC(),
    'costDESC': CostFilterDESC(),
    'titleASC': TitleFilterASC(),
    'titleDESC': TitleFilterDESC()
}

def get_filter(request):
    sort_cost = request.GET.get('sort_cost')
    sort_title = request.GET.get('sort_title')
    books = Book.objects.all()
    queryset = []
    if sort_title:
        filter_key = f'title{sort_title}'
        queryset = FILTERS.get(filter_key).add_filter(queryset)
    if sort_cost:
        filter_key = f'cost{sort_cost}'
        queryset = FILTERS.get(filter_key).add_filter(queryset)
    
    if not sort_title and not sort_cost:
        queryset.append('title')
    
    books = books.order_by(*queryset)
    return books

def book_list(request):
    books = get_filter(request)
    paginator = Paginator(books, 10)
    page_number = request.GET.get('page', 1)
    page_obj = paginator.get_page(page_number)

    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        books_html = render_to_string('books/book_list_partial.html', {
            'page_obj': page_obj,
            'user': request.user
        }, request=request)
        pagination_html = render_to_string('books/pagination_partial.html', {
            'page_obj': page_obj
        }, request=request)

        return JsonResponse({
            'books_html': books_html,
            'pagination_html': pagination_html
        })

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
        user_form = ChangeProfileForm(user, request.POST, instance=user)
        if user_form.is_valid():
            user_form.save()
            messages.success(request, "Профиль успешно обновлен")
            return redirect('profile', login=user_form.cleaned_data['login'])
    else:
        user_form = ChangeProfileForm(user, instance=user)

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
    cart_cookie = request.COOKIES.get(f'cart_{request.user.id}', '{}')
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
        f'cart_{request.user.id}',
        json.dumps(cart),
        max_age=31536000
    )

    messages.success(request, f"Книга \"{book.title}\" успешно добавлена в корзину")
    return response

@login_required
def cart(request):
    cart_cookie = request.COOKIES.get(f'cart_{request.user.id}', '{}')
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
    cart_cookie = request.COOKIES.get(f'cart_{request.user.id}', '{}')
    try:
        cart = json.loads(cart_cookie)
    except json.JSONDecodeError:
        cart = {}

    str_pk = str(pk)
    if str_pk in cart and cart[str_pk] > 1:
        cart[str_pk] -= 1
    elif str_pk in cart:
        del cart[str_pk]

    response = redirect('cart')
    response.set_cookie(
        f'cart_{request.user.id}',
        json.dumps(cart),
        max_age=31536000
    )

    messages.success(request, f"Книга \"{book.title}\" успешно удалена из корзины")
    return response
    
@login_required
def checkout(request):
    cart_cookie = request.COOKIES.get(f'cart_{request.user.id}')
    try:
        cart = json.loads(cart_cookie)
    except json.JSONDecodeError:
        cart = {}
    
    if not cart:
        messages.warning(request, "Корзина пуста")
        return redirect('cart')
    
    order = Order.objects.create(user_id=request.user.id)
    total_price = 0

    for bookID, quantity in cart.items():
        try:
            book = Book.objects.get(pk=bookID)
            OrderItem.objects.create(
                book_id=bookID,
                order_id=order.id,
                quantity=quantity
            )
            total_price += book.cost * quantity
        except Book.DoesNotExist:
            continue

    order.total_price = total_price
    order.save()

    response = redirect('cart')
    response.delete_cookie(f'cart_{request.user.id}')

    messages.success(request, "Заказ успешно оформлен")
    return response

@login_required
def orders(request):
    orders = Order.objects.filter(user_id=request.user.id)
    return render(request, 'books/order_list.html', {
        'orders': orders
    })

@login_required
def order_detail(request, pk):
    order = get_object_or_404(Order, id=pk, user_id=request.user.id)
    order_books = OrderItem.objects.filter(order_id=pk)
    return render(request, 'books/order_detail.html', {
        'order': order,
        'books': order_books
    })

class ValidateField(ABC):
    @abstractmethod
    def validate(self, value):
        pass

class LoginValidator(ValidateField):
    def validate(self, value):
        if User.objects.filter(login=value).exists():
            return {'error': 'Этот логин уже занят'}
        return {}
    
class MailValidator(ValidateField):
    def validate(self, value):
        pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
        if not re.match(pattern, value):
            return {'error': 'Некорректный email. Пример: user@domain.com'}
        
        if User.objects.filter(mail=value).exists():
            return {'error': 'Эта почта уже зарегистрирована'}
        return {}
    
class PasswordValidator(ValidateField):
    def validate(self, value):
        if len(value) < 6:
            return {'error': "Пароль должен быть не менее 6 символов"}
        return {}

VALIDATORS = {
    'login': LoginValidator(),
    'mail': MailValidator(),
    'password': PasswordValidator()
}
    
def validate_field(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Неверный запрос'}, status=400)

    try:
        data = json.loads(request.body)
        field = data.get('field')
        value = data.get('value')

        validator = VALIDATORS.get(field)
        if not validator:
            return JsonResponse({'error': 'Неизвестное поле'}, status=400)
        
        result = validator.validate(value)
        return JsonResponse(result)
    
    except json.JSONDecodeError:
        return JsonResponse({'error': 'Неверный формат данных'}, status=400)

    
        

