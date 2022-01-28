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

  String error_message = null;
  User user = (User) session.getAttribute("user");
  
  if (user == null) {
    error_message = "You have to be signed in to acquire a book";
  } else if (user.getCredits() < selectedBook.getPrice()) {
    error_message = "Sorry, you don't have enough credits";
  } else if (user.getAddress() == null) {
    error_message = "Please fill your address details from the account page";
  }
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="header.jsp" %>
    <title>Bookstack</title>
    <script defer src="js/jquery.min.js"></script>
    <script defer src="js/bookAcquisition.js"></script>
  </head>
  <body>
    <header class="header bg-light">
      <%@ include file="nav-menu.jsp" %>
    </header>

    <main>
      <section class="itm-preview-section">
        <div class="itm-preview-container">
          <div class="back-btn-container btn-preview">
            <ion-icon class="chevron-back-icon" name="chevron-back"></ion-icon>
            <button class="back-btn" onclick="history.back()">Back</button>
          </div>
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
            <%
            if (error_message == null) {
            %>
            <form action="servlet/BookAcquisitionServlet" method="GET" id="acquire_form">
              <input type="hidden" name="isbn" value="<%=isbn%>">
              <button type="submit" id="confirmation-btn" class="form-btn">
                Acquire 
              </button>
            </form>
            <%
            } else {
            %>
            <button disabled type="button" id="confirmation-btn" class="tooltip form-btn" href="#">
              Acquire 
              <span class="tooltiptext"><%=error_message %></span>
            </button>
            <%
            }
            %>
          </div>
        </div>
      </section>
    </main>

    <%@ include file="footer.jsp" %>

  </body>
</html>
