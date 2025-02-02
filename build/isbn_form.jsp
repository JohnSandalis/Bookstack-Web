<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>

<%@ include file="authenticate_user.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="header.jsp" %>
    <meta name="description" content="Search book by ISBNs">
    <title>ISBN</title>
  </head>
  <body>
    <header class="header">
      <%@ include file="nav-menu.jsp" %>
    </header>
    <section class="form-section">
      <form method="GET" class="form" action="isbn_form_controller.jsp">
        <div class="form-container">
          <p class="form-title">Search with ISBN</p>
<%
          if (request.getAttribute("alertText") != null) {
%>
          <p class="alert-danger"><%=request.getAttribute("alertText") %></p>
<%
          }
%>
          <div class="form-group">
            <label for="isbn">
              <ion-icon class="form-icon" name="barcode"></ion-icon>
            </label>
            <input type="text" name="isbn" id="isbn" placeholder="ISBN" />
          </div>
          <button class="form-btn" type="submit">Search</button>
        </div>
      </form>
    </section>
  <%@ include file="footer.jsp" %>
  </body>
</html>
