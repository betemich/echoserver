document.addEventListener('DOMContentLoaded', function() {
    const sortTitleSelect = document.getElementById('sort-title');
    const sortCostSelect = document.getElementById('sort-cost');
    const bookList = document.getElementById('book-list');
    const pagination = document.getElementById('pagination');

    book_list_url = '';

    function loadBooks(page = 1, updateHistory=true) {
        const sortTitle = sortTitleSelect.value
        const sortCost = sortCostSelect.value

        bookList.classList.add('loading');
        bookList.innerHTML = '';

        const params = new URLSearchParams({
            page: page,
            sort_title: sortTitle,
            sort_cost: sortCost
        });

        fetch(`${book_list_url}?${params.toString()}`, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
        .then(response => response.json())
        .then(data => {
            bookList.innerHTML = data.books_html;
            pagination.innerHTML = data.pagination_html;
            addPaginationListeners();

            if (updateHistory) {
                const newUrl = `${window.location.pathname}?${params.toString()}`;
                history.pushState({ page: page }, '', newUrl);
            }
            
        })
        .catch(error => {
            console.error('Error:', error);
            bookList.innerHTML = '<li>Ошибка при загрузке книг</li>';
        })
        .finally(() => {
            bookList.classList.remove('loading');
        });
    }

    function addPaginationListeners() {
        const pageLinks = pagination.querySelectorAll('a');
        pageLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const url = new URL(this.href);
                const page = url.searchParams.get('page') || 1;
                loadBooks(page);
            });
        });
    }

    sortTitleSelect.addEventListener('change', function() {
        loadBooks();
    });

    sortCostSelect.addEventListener('change', function() {
        loadBooks();
    });

    addPaginationListeners();
})