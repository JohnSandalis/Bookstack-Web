<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="header.jsp" %>
    <meta name="description" content="Bookstack - Error page">
    <title>Bookstack - Error</title>
  </head>
  <body>
    <header class="header bg-light">
      <a href="index.jsp" class="logo">Bookstack</a>

      <nav class="main-nav">
        <ul class="main-nav-list">
          <li><a class="main-nav-link" href="index.jsp">Home</a></li>
          <li><a class="main-nav-link" href="browse.jsp">Browse</a></li>
          <li><a class="main-nav-link" href="account.jsp">Account</a></li>
        </ul>
      </nav>

      <button class="btn-mobile-nav">
        <ion-icon class="icon-mobile-nav" name="menu-outline"></ion-icon>
        <ion-icon class="icon-mobile-nav" name="close-outline"></ion-icon>
      </button>
    </header>

    <main>
      <section class="section-error">
        <div class="error">
          <h1 class="heading-secondary error-heading">
            Oops something went wrong
          </h1>
          <h2 class="error-description-heading">An error has occured:</h2>
          	<% if(exception != null) { %>
						<p class="error-description"><code><%=exception %></code></p>
					  <% } %>
        </div>
      </section>
    </main>
    <%@ include file="footer.jsp" %>
  </body>
</html>
