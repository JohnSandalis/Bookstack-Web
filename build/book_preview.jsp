<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
  Book selectedBook = (Book) session.getAttribute("selectedBook");
  List<String> authors = selectedBook.getAuthors();
  StringBuilder sbAuthors = new StringBuilder();
  sbAuthors.append(authors.get(0));
  for (int i = 1; i < authors.size(); i++) {
    sbAuthors.append(",");
    sbAuthors.append(authors.get(i));
  }
  List<String> subjects = selectedBook.getSubjects();
  String builder sbSubjects = new StringBuilder();
  sbSubjects.append(subjects.get(0));
  for (int i = 1; i < subjects.size(); i++) {
    sbSubjects.append(",");
    sbSubjects.append(subjects.get(i));
  }
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="header.jsp" %>
    <title>Bookstack</title>
  </head>
  <body>
    <header class="header bg-light">
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

    <main>
      <section class="itm-preview-section">
        <div class="itm-preview-container">
          <div class="itm-img-col">
            <div class="img-box-preview">
              <img
                class="itm-img-preview"
                src="https://images-na.ssl-images-amazon.com/images/I/71iud2Nk92L.jpg"
                alt="book cover"
              />
            </div>
          </div>
          <div class="itm-description-col">
            <p class="itm-isbn">ISBN: <%=selectedBook.getIsbn()%></p>
            <h1 class="itm-title-preview"><%=selectedBook.getTitle()%></h1>
            <p class="itm-subtitle">
              <%=book.getSubtitle()%>
            </p>
            <p class="itm-preview">Author Names: <%=sbAuthors.toString()%></p>
            <p class="itm-preview">Publisher: <%=selectedBook.getPublisher()%></p>
            <p class="itm-preview">Publish Date: <%=selectedBook.getPublish_date()%></p>
            <p class="itm-preview">Page Count: <%=selectedBook.getPage.count()%></p>
            <p class="itm-preview">Subjects: <%=sbSubjects.toString()%></p>
            <p class="itm-preview">Language: <%=selectedBook.getLang()%></p>
            <div class="itm-credits-preview">
              <ion-icon class="credits-icon" name="cash-outline"></ion-icon>
              <span class="itm-credits"><%=selectedBook.getPrice()%></span>
            </div>
            <a class="btn btn-sm" href="#">Acquire</a>
          </div>
        </div>
      </section>
    </main>

    <%@ include file="footer.jsp" %>

  </body>
</html>
