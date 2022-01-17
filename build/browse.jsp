<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bookstack.*, java.sql.*, java.util.ArrayList, java.util.Date, java.util.List" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
]   <%@ include file="header.jsp" %>
    <meta name="description" content="Bookstack browse page where you can find all the available books to be acquired with credits">
    <title>Bookstack - Browse</title>
    <script defer src="js/jquery.min.js"></script>
    <script defer src="js/browse.js"></script>
  </head>
  <body>
    <header class="header bg-light">
      <%@ include file="nav-menu.jsp" %>
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
          <div class="browse-information">
            <%
            if ( session.getAttribute("user") != null ) {
              User user = (User) session.getAttribute("user");
            %>
            <div class="browse-credits">
              <ion-icon class="credits-icon" name="cash-outline"></ion-icon>

              <span class="credits"><%=user.getCredits()%></span>

            </div>
            <%
            }
            %>
            <a class="btn btn-md btn-trade" href="isbn_form.jsp">Trade-in</a>
          </div>
        </div>

        <div class="browse-container grid-browse">

          <% 
             for (int i = 0; i < 9; i++) { 
          %>
          <div class="item-container flex-item" id="bookContainer<%=i%>">
            <div class="itm-img-box">
              <img
                class="itm-img"
                src=""
                alt="book cover"
              />
            </div>
            <div class="itm-description-box">
              <p class="itm-title"></p>
              <p class="itm-author"></p>
              <a class="btn btn-sm btn-itm" href="">View Details</a>
            </div>
          </div>

          <%  }  %>
        </div>

        <div class="pagination">
          <button type="button" class="btn-page" id="prev">
            <ion-icon class="btn-icon" name="chevron-back-outline"></ion-icon>
          </button>

          <button type="button" class="btn-page" id="next">
            <ion-icon class="btn-icon" name="chevron-forward-outline"></ion-icon>
          </button>
        </div>
      </section>
    </main>
    <%@ include file="footer.jsp" %>
  </body>
</html>
