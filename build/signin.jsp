<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*"%>
<% request.setAttribute("destination", request.getHeader("Referer"));
   String alertText = (String)request.getAttribute("alertText");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="header.jsp" %>
    <meta name="description" content="Search book by ISBNs">
    <title>Sign In</title>
  </head>
  <body>
    <header class="header">
      <%@ include file="nav-menu.jsp" %>
    </header>
        <main>
            <section class="form-section">
                <form method="POST" class="form" action="signInController.jsp">
                <div class="form-container">
                    <p class="form-title">Sign in</p>
                    <%if (alertText != null){%>
                        <p class="alert-danger"><%=alertText%></p>
                    <%}%>
                    <div class="form-group">
                    <label for="email"
                        ><ion-icon class="form-icon" name="mail-open"></ion-icon
                    ></label>
                    <input type="text" name="email" id="email" placeholder="Email" />
                    </div>
                    <div class="form-group">
                    <label for="password"
                        ><ion-icon class="form-icon" name="lock-closed"></ion-icon
                    ></label>
                    <input
                        type="password"
                        name="password"
                        id="password"
                        placeholder="Password"
                    />
                    </div>
                    <button class="form-btn" type="submit">Log in</button>
                    <a class="form-link" href="signup.jsp">Not a member yet?</a>
                </div>
                </form>
            </section>
        </main>

    <%@ include file="footer.jsp" %>
</body>
</html>