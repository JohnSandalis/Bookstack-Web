<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="bookstack.*"%>
<%@ page import="java.util.List, org.apache.commons.lang3.StringUtils"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.lang.Integer"%>
<% String isbn = request.getParameter("isbn");
User user = (User)session.getAttribute("user");
String title = null;
String subtitle = null;
int pagesCount = 0;
String thumbnailUrl = null;
String lang = null;
Date publishDate = null;
String publisher = null;
String datet = null;
Book book = null;
try {
    book = DatabaseUtils.getBookFromISBN(isbn);
} catch (Exception e) {
    throw new Exception("Database exception");
}
    if (book == null) {
        title = request.getParameter("title");
        subtitle = request.getParameter("subtitle");
        pagesCount = Integer.parseInt(request.getParameter("page_count"));
        thumbnailUrl = request.getParameter("thumbnail_url");
        if (StringUtils.isNotBlank(thumbnailUrl)) {
            thumbnailUrl = "#";
        }
            publisher = request.getParameter("publisher");
            datet = request.getParameter("publish_date");
            SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
            if (StringUtils.isNotBlank(datet)) {
                publishDate = dateFormatter.parse(datet);
            }            
            lang = request.getParameter("language");        
            List<String> authors = Arrays.asList(request.getParameter("authors").split(", "));                
            List<String> subjects = Arrays.asList(request.getParameterValues("subjects"));
            //Create new book entry
            try {
                DatabaseUtils.createNewBook(isbn, title, subtitle, pagesCount, thumbnailUrl,
                publisher, publishDate, lang, 0, authors, subjects);
            } catch (Exception e) {
                throw new Exception("Database exception");
            } 
    }
    //Add book to users submissions
    DatabaseUtils.addBooksSubmitted(new Date(), user.getId(), isbn);
    try {
        user = DatabaseUtils.getUserFromUsernameAndPassword(user.getEmail(), user.getPassword());
    } catch (Exception e) {
        throw new Exception("Database exception");
    }
        //Update the books given by the user
    DatabaseUtils.updateUserBooksGiven(user.getBooksGiven() + 1, user.getId());

    session.setAttribute("user", user);
%>
<jsp:forward page="account.jsp"/>