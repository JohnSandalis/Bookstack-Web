<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>

<a href="index.jsp" class="logo">Bookstack</a>

<nav class="main-nav">
  <ul class="main-nav-list">
    <li><a class="main-nav-link" href="index.jsp">Home</a></li>
    <li><a class="main-nav-link" href="browse.jsp">Browse</a></li>
<%
if ( session.getAttribute("user") != null ) {
%>
    <li><a class="main-nav-link" href="account.jsp">Account</a></li>
<%
} else {
%>
    <li><a class="main-nav-link cta-link" href="signin.jsp">Sign in</a></li>
<%
}
%>
  </ul>
</nav>

<button class="btn-mobile-nav">
  <ion-icon class="icon-mobile-nav" name="menu-outline"></ion-icon>
  <ion-icon class="icon-mobile-nav" name="close-outline"></ion-icon>
</button>