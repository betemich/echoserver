from django import template

register = template.Library()

@register.filter
def ruble(cost) -> str:
    if int(cost / 10) % 10 == 1 or cost % 10 == 0 or cost % 10 >= 5:
        return "рублей"
    elif cost % 10 == 1:
        return "рубль"
    else:
        return "рубля"