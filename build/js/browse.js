jQuery( () => {
    $.ajax({
        url: 'http://ism.dmst.aueb.gr/ismgroup6/servlet/AvailableBookServlet',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
                books = data;
                addPaginationItems();
                loadBooks(); 
        }
    })


})

var currentPage = 1;
var totalPages = 1;
var leftEnd = 1;
var rightEnd = 1;
var books = []

/**
 * Gets values of books and sets them to the corresponding
 * HTML elements, by using jQuery
 * 
 * @param {Array} books 
 */
const loadBooks = () => {
    for (let i = 0; i < 9; i++) {
        const bookIndex = i + 9 * (currentPage - 1)
        const bookSelector = `#bookContainer${i}`;
        if (bookIndex >= books.length) {
            $(bookSelector).children().css("display", "none")
            continue;
        } else {
            $(bookSelector).children().css("display", "flex")
        }
        const authors = books[bookIndex].authors.join(", ");
        $(bookSelector + " p.itm-title").text(books[bookIndex].title);
        $(bookSelector + " p.itm-author").text(authors);
        $(bookSelector + " img.itm-img").attr("src", books[bookIndex].thumbnailUrl);
        $(bookSelector + " a.btn-itm").attr("href", `book_preview.jsp?isbn=${books[bookIndex].isbn}`)
    }
}

/**
 * Given the total number of books, creates pagination
 * items (eg. 1, 2, 3 etc)
 */
const addPaginationItems = () => {
    totalPages = Math.ceil(books.length / 9);
    rightEnd = totalPages
    setChevronState(currentPage)
    for (let i = 1; i <= totalPages; i++) {
        const paginationItem = document.createElement("button");
        paginationItem.setAttribute("class", "page-link");
        paginationItem.setAttribute("id", `page_${i}`)
        paginationItem.setAttribute("onclick", `changePage(${i})`)
        if (i == currentPage) {
            paginationItem.setAttribute("class", "page-link page-link--current");
        }
        const text = document.createTextNode(i.toString());
        paginationItem.append(text);
        $("div.pagination #next").before(paginationItem);
    }

};

/**
 * Changes page to given number and loads items accordingly.
 * 
 * @param {number} pageNum 
 */
const changePage = (pageNum) => {
    $(`#page_${currentPage}`).removeClass("page-link--current");
    currentPage = pageNum;
    setChevronState(currentPage)
    $(`#page_${pageNum}`).addClass("page-link--current");
    loadBooks()
};

/**
 * Changes Chevron-Buttons' state, based on current page
 * 
 * @param {number} currentPage 
 */
const setChevronState = (currentPage) => {
    if (currentPage == leftEnd) {
        $('div.pagination #prev').prop('disabled', true)
    } else {
        $('div.pagination #prev').prop('disabled', false)
    }

    if (currentPage == rightEnd) {
        $('div.pagination #next').prop('disabled', true)
    } else {
        $('div.pagination #next').prop('disabled', false)        
    }
}

const handleChevronClick = (isNext) => {
    if (isNext) {
        changePage(currentPage + 1)
    } else {
        changePage(currentPage - 1)
    }
}