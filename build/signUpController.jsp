<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*"%>
<%@ page import="java.util.regex.Pattern, java.util.regex.Matcher" %>
<% String email = request.getParameter("email");
String password = request.getParameter("password");
String destination = (String)request.getAttribute("destination");
String firstname = request.getParameter("firstname");
String lastname = request.getParameter("lastname");
String username = request.getParameter("username");
String confirm_password = request.getParameter("confirm_password");
int count_errors = 0;
int count1 = 0;
int count2 = 0;
int count3 = 0;
int count4 = 0;
int count5 = 0;
if (lastname == null || lastname.length() < 3){
    count_errors ++;
    count1++;
} if(username == null || username.length() < 4){
    count_errors ++;
    count2++;
} if(password == null || password.length() < 4){
    count_errors ++;
    count3++;
} if(confirm_password == null || !(confirm_password.equals(password))){
    count_errors ++;
    count4++;
}
String ePattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";
    java.util.regex.Pattern p = java.util.regex.Pattern.compile(ePattern);
    java.util.regex.Matcher m = p.matcher(email);
    
if( !m.matches() || email == null) {				
        count5++;
        count_errors ++;
}
if (count_errors > 0 ) {
    destination = "signup.jsp";
    String alertText = null;
    if (count1 > 0) {
        alertText = "Last name must be at least 3 characters long";
        request.setAttribute("alertText", alertText);
    }
    else if (count2 > 0) {
        alertText = "Username must be at least 5 characters long";
        request.setAttribute("alertText", alertText);
    }
    else if (count3 > 0) {
        alertText = "Password must be at least 6 characters long";
        request.setAttribute("alertText", alertText);
    }
    else if (count4 > 0) {
        alertText = "Password and confirm do not match";
        request.setAttribute("alertText", alertText);
    }
    else if (count5 > 0) {
        alertText = "Your email is not valid";
        request.setAttribute("alertText", alertText);
    }
    
}
else {
        try {
            DatabaseUtils.createNewUser(firstname, lastname, username,
            email, password);
            User user = DatabaseUtils.getUserFromUsernameAndPassword(email, password);
            session.setAttribute("user", user);
        } catch(Exception e) {
            e.printStackTrace();
        }
}
if (destination == null) {
    destination = "index.jsp";
}%>
<jsp:forward page="<%=destination%>"/>








