from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from selenium_stealth import stealth
import time
import uuid

chrome_options = Options()
chrome_options.add_argument("--ignore-certificate-errors")
chrome_options.add_argument("--allow-insecure-localhost")
chrome_options.add_argument("--disable-web-security")
chrome_options.add_argument("start-maximized")
chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
chrome_options.add_experimental_option('useAutomationExtension', False)
chrome_options.add_experimental_option("prefs", {
    "credentials_enable_service": False,
    "profile.password_manager_leak_detection": False
})

def test1():
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

    try:
        driver.get("http://localhost:8000/login/")

        time.sleep(1.5)

        login = driver.find_element(By.NAME, "user_login")
        login.send_keys("lervqq")

        time.sleep(1.5)

        password = driver.find_element(By.NAME, "password")
        password.send_keys("111")

        time.sleep(1.5)

        login_btn = driver.find_element(By.CLASS_NAME, "btn")
        login_btn.click()

        time.sleep(1.5)

        add_btn = driver.find_element(By.XPATH, "//a[@href='/create/']")
        add_btn.click()

        time.sleep(1.5)

        namebook = driver.find_element(By.NAME, "title")
        namebook.send_keys("Мы")

        time.sleep(1.5)

        author = driver.find_element(By.NAME, "author")
        author.send_keys("Евгений Замятин")

        time.sleep(1.5)

        author = driver.find_element(By.NAME, "cost")
        author.send_keys("10")

        time.sleep(1.5)

        save_btn = driver.find_element(By.XPATH, "//button[@type='submit']")
        save_btn.click()

        time.sleep(1.5)

        add_to_cart_button = driver.find_element(
            By.XPATH,
            "//li[contains(., 'Мы')]//a[contains(@class, 'add-to-cart-link')]"
        )
        add_to_cart_button.click()

        time.sleep(1.5)

        cart_btn = driver.find_element(By.XPATH, "//a[@href='/cart']")
        cart_btn.click()

        time.sleep(1.5)

        order_btn = driver.find_element(By.CLASS_NAME, "checkout-link")
        order_btn.click()

        time.sleep(1.5)

        main_btn = driver.find_element(By.XPATH, "//a[@href='/']")
        main_btn.click()

        time.sleep(1.5)

        account_btn = driver.find_element(By.XPATH, "//a[@href='/profile/lervqq/']")
        account_btn.click()

        time.sleep(1.5)

        orders_btn = driver.find_element(By.XPATH, "//a[@href='/orders']")
        orders_btn.click()

        time.sleep(5)

        driver.save_screenshot("screenshots/test1.png")

    except Exception as e:
        print(f"Ошибка в тесте: {str(e)}")

    finally:

        time.sleep(1.5)
        driver.quit()

def test2():
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

    try:
        driver.get("http://localhost:8000/register/")

        time.sleep(1.5)

        random_login = f'login{uuid.uuid4()}'
        login = driver.find_element(By.NAME, "login")
        login.send_keys(random_login)

        time.sleep(1.5)

        user_name = driver.find_element(By.NAME, "user_name")
        user_name.send_keys("Art")

        time.sleep(1.5)

        random_email = f'email{uuid.uuid4()}@ya.ru'
        email = driver.find_element(By.NAME, "mail")
        email.send_keys(random_email)

        time.sleep(1.5)

        password = driver.find_element(By.NAME, "password")
        password.send_keys("123654")

        time.sleep(1.5)

        confirm_password = driver.find_element(By.NAME, "confirm_password")
        confirm_password.send_keys("123654")

        time.sleep(1.5)

        register = driver.find_element(By.XPATH, "//button[@type='submit']")
        register.click()

        time.sleep(1.5)

        login = driver.find_element(By.NAME, "user_login")
        login.send_keys(random_login)

        time.sleep(1.5)

        password = driver.find_element(By.NAME, "password")
        password.send_keys("123654")

        time.sleep(1.5)

        login_btn = driver.find_element(By.CLASS_NAME, "btn")
        login_btn.click()

        time.sleep(1.5)

        profile_btn = driver.find_element(By.XPATH, f"//a[@href='/profile/{random_login}/']")
        profile_btn.click()

        time.sleep(1.5)

        account_btn = driver.find_element(By.XPATH, f"//a[@href='/profile/{random_login}/?edit=true']")
        account_btn.click()

        time.sleep(1.5)

        change_login = driver.find_element(By.NAME, "login")
        change_login.send_keys("Tutut")

        time.sleep(1.5)

        save_changes = driver.find_element(By.XPATH, "//button[@type='submit']")
        save_changes.click()

        time.sleep(1.5)

        go_back = driver.find_element(By.CLASS_NAME, 'back-link')
        go_back.click()

        driver.save_screenshot("screenshots/test2.png")

    except Exception as e:
        print(f'Ошибка в тесте: {str(e)}')

    finally:

        time.sleep(1.5)
        driver.quit()

test1()
test2()