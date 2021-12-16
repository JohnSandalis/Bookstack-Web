<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>

<%
if ( session.getAttribute("user") == null ) {

	request.setAttribute("alertText", "You are not authorized to access this page, please sign in");
%>

	<jsp:forward page="signin.jsp" />  

<%
    return;
}
%>