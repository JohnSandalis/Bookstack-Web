<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.Timestamp"%>
<% String isbn = request.getParameter("isbn");
User user = (User)session.getAttribute("user");
Book book = DatabaseUtils.getBookFromISBN(isbn);
if (book == null) {
    String title = request.getParameter("title");
    String subtitle = request.getParameter("subtitle");
    int pagesCount = request.getParameter("page_count");
    String thumbnailUrl = request.getParameter("thumbnail_url");
    String publisher = request.getParameter("publisher");
    Date publishDate = (Date)request.getParameter("publish_date");
    String lang = request.getParameter("language");
    List<String> authors = Arrays.asList(request.getParameter("authors").split(" ,"));
    List<String> subjects = request.getParameterValues("subjects");
    <!--Create new book entry-->
    DatabaseUtils.createNewBook(isbn, title, subtitle, pagesCount, thumbnailUrl,
    publisher, publishDate, lang, int price, authors,
    subjects);
}
<!--Add book to users submissions-->
DatabaseUtils.addBooksSubmitted(new Timestamp(Date.getTime()), user.getId(), isbn);%>
<jsp:forward page="index.jsp"/>