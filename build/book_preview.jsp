<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*" %>
<%@ page import="java.util.List, java.util.ArrayList, org.apache.commons.lang3.StringUtils" %>

<%
  String isbn = request.getParameter("isbn");
  Book selectedBook = null;
  try {
    selectedBook = DatabaseUtils.getBookFromISBN(isbn);
  } catch (Exception e) {
    throw new Exception("getBookFromISBN error");
  }

  if (selectedBook == null) {
    %>
    <jsp:forward page="browse.jsp"/>
    <%
  }

  String authors = StringUtils.join(selectedBook.getAuthors(), ", ");

  String subjects = StringUtils.join(selectedBook.getSubjects(), ", ");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="header.jsp" %>
    <title>Bookstack</title>
  </head>
  <body>
    <header class="header bg-light">
      <%@ include file="nav-menu.jsp" %>
    </header>

    <main>
      <section class="itm-preview-section">
        <div class="itm-preview-container">
          <div class="itm-img-col">
            <div class="img-box-preview">
              <img
                class="itm-img-preview"
                src="<%=selectedBook.getThumbnailUrl()%>"
                alt="book cover"
              />
            </div>
          </div>
          <div class="itm-description-col">
            <p class="itm-isbn">ISBN: <%=selectedBook.getIsbn()%></p>
            <h1 class="itm-title-preview"><%=selectedBook.getTitle()%></h1>
            <p class="itm-subtitle">
              <%=selectedBook.getSubtitle()%>
            </p>
            <p class="itm-preview">Author Names: <%=authors%></p>
            <p class="itm-preview">Publisher: <%=selectedBook.getPublisher()%></p>
            <p class="itm-preview">Publish Date: <%=selectedBook.getPublishDate()%></p>
            <p class="itm-preview">Page Count: <%=selectedBook.getPageCount()%></p>
            <p class="itm-preview">Subjects: <%=subjects%></p>
            <p class="itm-preview">Language: <%=selectedBook.getLang()%></p>
            <div class="itm-credits-preview">
              <ion-icon class="credits-icon" name="cash-outline"></ion-icon>
              <span class="itm-credits"><%=selectedBook.getPrice()%></span>
            </div>
            <a class="btn btn-md" href="#">Acquire</a>
          </div>
        </div>
      </section>
    </main>

    <%@ include file="footer.jsp" %>

  </body>
</html>
