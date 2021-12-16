<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bookstack.*, java.sql.*, java.util.ArrayList, java.util.Date, java.util.List" %>
<%@ page errorPage="error.jsp" %>

<%@ include file="authenticate_user.jsp" %>

<%
User user = (User) session.getAttribute("user");

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
              <p class="information"><%=user.getAddress() %></p>
              <p class="information"><%=user.getCity() %></p>
              <p class="information"><%=user.getRegion() %></p>
              <p class="information"><%=user.getPostalCode() %></p>
              <p class="information"><%=user.getPhoneNumber() %></p>
              <p class="information"><%=user.getCountry() %></p>
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
            <div class="item-container flex-item">
              <div class="itm-img-box">
                <img
                  class="itm-img"
                  src="https://images-na.ssl-images-amazon.com/images/I/71iud2Nk92L.jpg"
                  alt="book cover"
                />
              </div>
              <div class="itm-description-box">
                <p class="itm-title">Unscripted</p>
                <p class="itm-author">M. J. Demarco</p>
                <a class="btn btn-sm btn-itm" href="#">Edit Entry</a>
              </div>
            </div>

            <div class="item-container flex-item">
              <div class="itm-img-box">
                <img
                  class="itm-img"
                  src="http://books.google.com/books/content?id=eifwjwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
                  alt="book cover"
                />
              </div>
              <div class="itm-description-box">
                <p class="itm-title">The Subtle Art of Not Giving a F*ck</p>
                <p class="itm-author">Mark Manson</p>
                <a class="btn btn-sm btn-itm" href="#">Edit Entry</a>
              </div>
            </div>

            <div class="item-container flex-item">
              <div class="itm-img-box">
                <img
                  class="itm-img"
                  src="https://m.media-amazon.com/images/I/61qSRYof0-L.jpg"
                  alt="book cover"
                />
              </div>
              <div class="itm-description-box">
                <p class="itm-title">
                  Magnus Chase and the Gods of Asgard, Book 1
                </p>
                <p class="itm-author">Rick Riordan</p>
                <a class="btn btn-sm btn-itm" href="#">Edit Entry</a>
              </div>
            </div>
          </div>

          <div class="pagination">
            <button class="btn-page">
              <ion-icon class="btn-icon" name="chevron-back-outline"></ion-icon>
            </button>

            <a href="#" class="page-link">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link page-link--current">3</a>
            <a href="#" class="page-link">4</a>

            <button class="btn-page">
              <ion-icon
                class="btn-icon"
                name="chevron-forward-outline"
              ></ion-icon>
            </button>
          </div>
        </section>
      </div>
    </main>
    <%@ include file="footer.jsp" %>
  </body>
</html>
