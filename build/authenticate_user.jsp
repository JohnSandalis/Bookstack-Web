<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>

<%
if ( session.getAttribute("user") == null ) {

	request.setAttribute("error_message", "You are not authorized to access this page!");
%>

	<jsp:forward page="login.jsp" />  

<%
    return;
}
%>