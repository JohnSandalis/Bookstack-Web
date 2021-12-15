<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.util.List, org.apache.commons.lang3.StringUtils, java.util.HashMap"%>
<%@ page import="bookstack.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="header.jsp" %>
    <meta name="description" content="Search book by ISBNs">
    <title>Bookstack - Browse</title>
  </head>
  <body>
    <header class="header">
    <a href="index.html" class="logo">Bookstack</a>

    <nav class="main-nav">
      <ul class="main-nav-list">
        <li><a class="main-nav-link" href="index.html">Home</a></li>
        <li><a class="main-nav-link" href="browse.html">Browse</a></li>
        <li><a class="main-nav-link" href="account.html">Account</a></li>
      </ul>
    </nav>
    <button class="btn-mobile-nav">
        <ion-icon class="icon-mobile-nav" name="menu-outline"></ion-icon>
        <ion-icon class="icon-mobile-nav" name="close-outline"></ion-icon>
      </button>
    </header>

<% 
String isbn = request.getParameter("isbn");


String alertClass = "danger";
String alertText = "No book info, please fill in the form manually";
HashMap<String, String> inputValues = new HashMap<String, String>();

if (StringUtils.isNotBlank(isbn)) {

  Book book = null;

  // Search isbn in DB
  try {
    book = DatabaseUtils.getBookFromISBN(isbn);
  } catch (Exception e) {
    e.printStackTrace(); // TODO Handle exception
  }

  // Seatch isbn through API
  if (book == null) {
    try {
      book = Book_handler.search_by_isbn(isbn);
    } catch (Exception e) {
      e.printStackTrace(); // TODO Handle exception
    }
    
  }

  if (book != null ) {
    alertClass = "success";
    alertText = "Book information found";
    inputValues.put("isbn", book.getIsbn());
    inputValues.put("title", book.getTitle());
    inputValues.put("subtitle", book.getSubtitle());
    inputValues.put("authors", StringUtils.join(book.getAuthors(), ", "));
    inputValues.put("publisher", book.getPublisher());
    inputValues.put("publishDate", book.getPublishDate().toString());
    inputValues.put("pageCount", String.valueOf(book.getPageCount()));
    inputValues.put("thumbnailUrl", book.getThumbnailUrl());
    inputValues.put("lang", book.getLang());
    inputValues.put("subjects", StringUtils.join(book.getSubjects(), ", "));
  }

}
%>
      <!-- Form -->
      <section class="form-section">
        <form method="POST" class="form">
          <div class="form-container">
            <p class="form-title">Trade-in your book</p>
            <p class="alert-<%=alertClass%>"><%=alertText%></p>

            <!-- ISBN -->
            <div class="form-group">
              <label for="isbn">
                  <ion-icon class="form-icon" name="barcode"></ion-icon>
              </label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("isbn"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("isbn"))%>"
                type="text"
                name="isbn"
                id="isbn"
                placeholder="ISBN"
              />
            </div>

            <!-- Title -->
            <div class="form-group">
              <label for="title"
                ><ion-icon class="form-icon" name="text"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("title"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("title"))%>"
                type="text"
                name="title"
                id="title"
                placeholder="Title"
              />
            </div>

            <!-- Subtitle -->
            <div class="form-group">
              <label for="subtitle"
                ><ion-icon class="form-icon" name="text-outline"></ion-icon
              ></label>
              <input
              <%
                  if (StringUtils.isNotBlank(inputValues.get("subtitle"))) {
              %>
              disabled
              <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("subtitle"))%>"
                type="text"
                name="subtitle"
                id="subtitle"
                placeholder="Subtitle"
              />
            </div>

            <!-- Author -->
            <div class="form-group">
              <label for="author"
                ><ion-icon class="form-icon" name="person"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("authors"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("authors"))%>"
                type="text"
                name="author"
                id="author"
                placeholder="Authors (ex Author1, Author2...)"
              />
            </div>

            <!-- Publisher -->
            <div class="form-group">
              <label for="publisher"
                ><ion-icon class="form-icon" name="person-circle"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("publisher"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("publisher"))%>"
                type="text"
                name="publisher"
                id="publisher"
                placeholder="Publisher"
              />
            </div>

            <!-- Publish Date -->
            <div class="form-group">
              <label for="publish_date"
                ><ion-icon class="form-icon" name="calendar"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("publishDate"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("publishDate"))%>"
                type="text"
                name="publish_date"
                id="publish_date"
                placeholder="Publish Date"
                onfocus="(this.type='date')"
                onblur="(this.type='text')"
              />
            </div>

            <!-- Number of pages -->
            <div class="form-group">
              <label for="page_count"
                ><ion-icon class="form-icon" name="documents"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("pageCount"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("pageCount"))%>"
                type="number"
                name="page_count"
                id="page_count"
                placeholder="Number of pages"
              />
            </div>

            <!-- Thumbnail URL -->
            <div class="form-group">
              <label for="thumbnail_url"
                ><ion-icon class="form-icon" name="code"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("thumbnailUrl"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("thumbnailUrl"))%>"
                type="text"
                name="thumbnail_url"
                id="thumbnail_url"
                placeholder="Cover Image url"
              />
            </div>

            <!-- Language -->
            <div class="custom-select form-group">
              <label for="language"
                ><ion-icon class="form-icon" name="earth"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("lang"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("lang"))%>"
                type="text"
                name="language"
                id="Language"
                placeholder="Language"
                required
              />
              <span class="remove-arrow"></span>
            </div>
            
            <!-- Subjects -->
            <div class="custom-select form-group">
              <label for="subjects"
                ><ion-icon class="form-icon" name="menu"></ion-icon
              ></label>
                <input
                <%
                  if (StringUtils.isNotBlank(inputValues.get("subjects"))) {
                %>
                disabled
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("subjects"))%>"
                type="text"
                name="subjects"
                id="subjects"
                placeholder="Subjects"
                required
              />
              <span class="remove-arrow"></span>
            </div>

            <button class="form-btn" type="submit">Continue</a>
          </div>
        </form>
      </section>

      <%@ include file="footer.jsp" %>
  </body>
</html>
