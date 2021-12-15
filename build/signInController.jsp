<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*"%>
<%@ page import="java.util.regex.Pattern, java.util.regex.Matcher" %>
<% String email = request.getParameter("email");
String password = request.getParameter("password");
String destination = (String)request.getAttribute("destination");
try{
    User user = DatabaseUtils.getUserFromUsernameAndPassword(email, password);
    if (user == null) {
        String alertText = "Wrong email or password. User does not exist.";
        request.setAttribute("alertText", alertText);%>
        <jsp:forward page="signin.jsp"/>
    <%} else {
        session.setAttribute("user", user);
      }
} catch(Exception e) {
    e.printStackTrace();
}
if (destination == null) {
    destination = "index.jsp";
}%>
<jsp:forward page="<%=destination%>"/>






