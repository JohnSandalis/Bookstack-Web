<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="header.jsp" %>
    <meta name="description" content="Search book by ISBNs">
    <title>Bookstack - Browse</title>
  </head>
  <body>
    <header class="header"></header>
    <a href="index.html" class="logo">Bookstack</a>

    <nav class="main-nav">
      <ul class="main-nav-list">
        <li><a class="main-nav-link" href="index.html">Home</a></li>
        <li><a class="main-nav-link" href="browse.html">Browse</a></li>
        <li><a class="main-nav-link" href="account.html">Account</a></li>
      </ul>
    </nav>
    <button class="btn-mobile-nav">
        <ion-icon class="icon-mobile-nav" name="menu-outline"></ion-icon>
        <ion-icon class="icon-mobile-nav" name="close-outline"></ion-icon>
      </button>
    </header>
<section class="form-section">
    <form method="POST" class="form">
      <div class="form-container">
        <p class="form-title">Search with ISBN</p>
        <div class="form-group">
          <label for="isbn">
            <ion-icon class="form-icon" name="barcode"></ion-icon>
          </label>
          <input type="text" name="isbn" id="isbn" placeholder="ISBN" />
        </div>
        <a class="form-btn" href="#">Search</a>
      </div>
    </form>
  </section>
  <%@ include file="footer.jsp" %>
  </body>
</html>
