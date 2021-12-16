<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bookstack.*, java.sql.*, java.util.ArrayList, java.util.Date, java.util.List" %>
<%@ page errorPage="error.jsp" %>

<%@ include file="authenticate_user.jsp" %>

<%
User user = (User) session.getAttribute("user");

List<BookSubmission> userBooks = new ArrayList<BookSubmission>();
List<Book> books = new ArrayList<Book>();
DatabaseUtils db = new DatabaseUtils();
try {
  userBooks = db.getUserSubmittedBooks(user.getId());
  for (int i = 0; i < userBooks.size(); i++) {
    books.add(userBooks.get(i).getBook());
  }
} catch (Exception e) {}
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
      <div class="profile-heading-container mb-sm">
        <h1 class="heading-profile">Profile</h1>
        <a class="btn btn-md" href="isbn_submission.jsp">Trade-in</a>
      </div>

      <div class="profile-page">
        <section class="profile-section">
          <div class="profile">
            <div class="account-container">
              <h3 class="information-heading"><%=user.getFullName() %></h3>
              <p class="information"><%=user.getUsername() %></p>
              <p class="information">
                <%=user.getEmail() %>
              </p>
              <p class="information"><%=user.getLang() %></p>


              <h3 class="information-heading">Address</h3>
<%
              if(user.getAddress() == null && user.getCity() == null && user.getRegion() == null && user.getPostalCode() == null && user.getPhoneNumber() == null && user.getCountry() == null) {
%>
              <a class="btn btn-md address-form-btn" href="address_form.jsp">Address form</a>
<%
              } else {
%>

<%
              }
%>
              <p class="information"><%=(user.getAddress() != null) ? user.getAddress() : ""%></p>
              <p class="information"><%=(user.getCity() != null) ? user.getCity() : ""%></p>
              <p class="information"><%=(user.getRegion() != null) ? user.getRegion() : ""%></p>
              <p class="information"><%=(user.getPostalCode() != null) ? user.getPostalCode() : ""%></p>
              <p class="information"><%=(user.getPhoneNumber() != null) ? user.getPhoneNumber() : ""%></p>
              <p class="information"><%=(user.getCountry() != null) ? user.getCountry() : ""%></p>
            </div>
          </div>
        </section>

        <div class="stats">
          <div class="stats-item profile-credits">
            <ion-icon class="credits-icon" name="cash-outline"></ion-icon>
            <span class="credits"><%=user.getCredits() %></span>
          </div>
          <p class="stats-item books-traded-in">Books Traded: &nbsp;<strong><%=user.getBooksGiven() %></strong></p>
          <p class="stats-item books-acquired">Books Acquired: &nbsp;<strong><%=user.getBooksTaken() %></strong></p>
        </div>

        <section class="browse-section">
          <div class="browse-container grid-browse">
<%
            for (Book book: books) {
                List<String> authors = book.getAuthors();
                StringBuilder sbAuthors = new StringBuilder();
                sbAuthors.append(authors.get(0));
                for (int i = 1; i < authors.size(); i++) {
                  sbAuthors.append(",");
                  sbAuthors.append(authors.get(i));
                }
%>
            <div class="item-container flex-item">
              <div class="itm-img-box">
                <img
                  class="itm-img"
                  src="<%=book.getThumbnailUrl() %>"
                  alt="book cover"
                />
              </div>
              <div class="itm-description-box">
                <p class="itm-title"><%=book.getTitle() %></p>
                <p class="itm-author"><%=sbAuthors.toString() %></p>
                <a class="btn btn-sm btn-itm" href="#">Edit Entry</a>
              </div>
            </div>
<%
            }
%>
        </section>
      </div>
    </main>
    <%@ include file="footer.jsp" %>
  </body>
</html>
