<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page errorPage="error.jsp" %>

<%
String isbn = request.getParameter("isbn");

if (StringUtils.isNotBlank(isbn) && StringUtils.isNumeric(isbn) && ((isbn.length() == 10) || (isbn.length() == 13))) {
  request.setAttribute("isbn", isbn);
%>
	<jsp:forward page="book_form.jsp" />
<%
} else {
  request.setAttribute("alertText", "Invalid isbn. Must be a 10 or 13 digit number. (you can find your book's isbn on the back cover)");
%>
	<jsp:forward page="isbn_form.jsp" />
<%
}
%>