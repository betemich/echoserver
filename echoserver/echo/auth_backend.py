from django.contrib.auth.backends import BaseBackend
from django.contrib.auth.hashers import check_password
from .models import User

class CustomAuthBackend(BaseBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        try:
            user = User.objects.get(login=username)
            if check_password(password, user.password):
                return user
            return None
        except User.DoesNotExist:
            return None
        
    def get_user(self, user_id):
        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return None
        