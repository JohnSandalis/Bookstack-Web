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
      <%@ include file="nav-menu.jsp" %>
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
