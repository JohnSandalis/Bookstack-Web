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
    <meta name="description" content="Sign up">
    <title>Sign Up</title>
  </head>
  <body>
    <header class="header">
      <%@ include file="nav-menu.jsp" %>
    </header>
        <main>
            <section class="form-section">
                <form method="POST" class="form" action="signUpController.jsp">
                  <div class="form-container">
                    <p class="form-title">Sign up</p>
                    <%if (alertText != null){%>
                      <p class="alert-danger"><%=alertText%></p>
                    <%}%>
                    <div class="form-group">
                      <label for="firstname"
                        ><ion-icon class="form-icon" name="person"></ion-icon
                      ></label>
                      <input
                        type="text"
                        name="firstname"
                        id="firstname"
                        placeholder="First Name"
                      />
                    </div>
                    <div class="form-group">
                      <label for="lastname"
                        ><ion-icon class="form-icon" name="person"></ion-icon
                      ></label>
                      <input
                        type="text"
                        name="lastname"
                        id="lastname"
                        placeholder="Last Name"
                      />
                    </div>
                    <div class="form-group">
                      <label for="username"
                        ><ion-icon class="form-icon" name="person-circle"></ion-icon
                      ></label>
                      <input
                        type="text"
                        name="username"
                        id="username"
                        placeholder="Username"
                      />
                    </div>
                    <div class="form-group">
                      <label for="email"
                        ><ion-icon class="form-icon" name="mail-open"></ion-icon
                      ></label>
                      <input type="email" name="email" id="email" placeholder="Email" />
                    </div>
                    <div class="form-group">
                      <label for="password"
                        ><ion-icon class="form-icon" name="lock-open"></ion-icon
                      ></label>
                      <input
                        type="password"
                        name="password"
                        id="password"
                        placeholder="Password"
                      />
                    </div>
                    <div class="form-group">
                      <label for="confirm_password"
                        ><ion-icon class="form-icon" name="lock-closed"></ion-icon
                      ></label>
                      <input
                        type="password"
                        name="confirm_password"
                        id="confirm_password"
                        placeholder="Confirm Password"
                      />
                    </div>
                    <button class="form-btn" type="submit">Register</button>
                    <a class="form-link" href="signin.jsp">Already have an account?</a>
                  </div>
                </form>
              </section>
        </main>

    <%@ include file="footer.jsp" %>
</body>
</html>