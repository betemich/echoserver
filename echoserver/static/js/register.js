document.addEventListener('DOMContentLoaded', function() {
    const loginInput = document.getElementById('login');
    const mailInput = document.getElementById('mail');
    const passwordInput = document.getElementById('password');
    const form = document.querySelector('form');
    const csrfToken = document.querySelector('[name=csrfmiddlewaretoken]').value;

    function removeErrorMessage(input) {
        const existingError = input.parentElement.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }
    }

    function addErrorMessage(input, message) {
        removeErrorMessage(input);
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.innerHTML = `<p>${message}</p>`;
        input.parentElement.appendChild(errorDiv);
    }

    function checkField(input, fieldName) {
        const value = input.value.trim();
        if (!value) return;

        fetch('/validate_field/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json', 
                'X-CSRFToken': csrfToken,
                'X-Validation-Request': 'true'
            },
            body: JSON.stringify({
                field: fieldName,
                value: value
            })
        })
        .then(response => {
            return response.json();
        })
        .then(data => {
            if (data.error) {
                addErrorMessage(input, data.error);
            } else {
                removeErrorMessage(input);
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
            addErrorMessage(input, 'Произошла ошибка при проверке');
        });
    }

    loginInput.addEventListener('blur', function() {
        checkField(this, 'login'); 
    });

    mailInput.addEventListener('blur', function() {
        checkField(this, 'mail'); 
    });

    passwordInput.addEventListener('blur', function() {
        checkField(this, 'password');
    });

    form.addEventListener('submit', function(e) {
        const errorMessages = form.querySelectorAll('.error-message'); 
        if (errorMessages.length > 0) {
            e.preventDefault();
            alert('Пожалуйста, исправьте ошибки перед отправкой формы');
        }
    });
});