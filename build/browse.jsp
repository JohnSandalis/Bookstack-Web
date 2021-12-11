<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bookstack.*, java.sql.*, java.util.ArrayList, java.util.Date, java.util.List" %>
<%@ page errorPage="error.jsp" %>

<%

if (session.getAttribute("current_page") == null) {
  int page = 1;
} else {
  int page = session.getAttribute("current_page");
}

DatabaseUtils db = new DatabaseUtils();

try {
  List<BookSubmission> bookSubmissions = db.getSubmittedBooks();
} catch(Exception e) {
  throw new Exception(e.getMessage());
}



%>

<!DOCTYPE html>
<html lang="en">
  <head>
]   <%@ include file="header.jsp" %>
    <meta name="description" content="Bookstack browse page where you can find all the available books to be acquired with credits"
    <title>Bookstack - Browse</title>
  </head>
  <body>
    <header class="header bg-light">
      <a href="index.jsp" class="logo">Bookstack</a>

      <nav class="main-nav">
        <ul class="main-nav-list">
          <li><a class="main-nav-link" href="index.jsp">Home</a></li>
          <li><a class="main-nav-link" href="#">Browse</a></li>
          <li><a class="main-nav-link" href="account.jsp">Account</a></li>
        </ul>
      </nav>

      <button class="btn-mobile-nav">
        <ion-icon class="icon-mobile-nav" name="menu-outline"></ion-icon>
        <ion-icon class="icon-mobile-nav" name="close-outline"></ion-icon>
      </button>
    </header>

    <main>
      <section class="section-hero">
        <div class="hero">
          <div class="hero-img-box">
            <img
              src="images/books-for-sale.jpg"
              class="hero-img"
              alt="Person reading book"
            />
          </div>

          <div class="hero-text-box">
            <h1 class="heading-primary">
              Here you can find all the available books at our warehouse.
            </h1>
            <p class="hero-text">
              Below are all of the books that can be acquired if someone has
              enough credits. Take a look and if you find a book interesting you
              can view more details about it. <br />
              <br />
              To acquire a book you need to provide us with your address and
              have the required amount of credits. After requesting a book, we
              will ship it right to your doorstep.
            </p>
          </div>
        </div>
      </section>

      <section class="browse-section">
        <div class="browse">
          <p class="browse-heading">Browse Books</p>
          <div class="information">
            <div class="browse-credits">
              <ion-icon class="credits-icon" name="cash-outline"></ion-icon>
              <span class="credits">1.100</span>
            </div>

            <a class="btn btn-md btn-trade" href="#">Trade-in</a>
          </div>
        </div>

        <div class="browse-container grid-browse">

          <% 
            /* for (int i = 0; i <= books_list.size(); i++) { */
          %>
          <div class="item-container flex-item">
            <div class="itm-img-box">
              <img
                class="itm-img"
                src="<%= /*get thumbnail_url of book i*/%>"
                alt="book cover"
              />
            </div>
            <div class="itm-description-box">
              <p class="itm-title"><%= /*get title of book i*/%></p>
              <p class="itm-author"><%= /*get author(s) of book i*/%></p>
              <a class="btn btn-sm btn-itm" href="#">View Details</a>
            </div>
          </div>

          <% /* } */ %>
        </div>

        <div class="pagination">
          <button class="btn-page">
            <ion-icon class="btn-icon" name="chevron-back-outline"></ion-icon>
          </button>

          <%  /*
          Not sure how href is going to work with pagination and jsp
          
          if (pages <= 7) {
            for (int i = 1; i <= pages; i++) { */ %>
              <a href="#" class="page-link <%= (current_page == i) ? "page-link--current" : "" %>">i</a>
          <%  /*
            }
          } else { 
            for (int i = ++++++++)
          */ %>

            <%--  ++++++++++
              <a href="#" class="page-link">1</a>

            <a href="#" class="page-link"><%= /* pages */</a> --%>
            <% /*
            } 
            */ %>
          <button class="btn-page">
            <ion-icon
              class="btn-icon"
              name="chevron-forward-outline"
            ></ion-icon>
          </button>
        </div>
      </section>
    </main>
    <%@ include file="footer.jsp" %>
  </body>
</html>
