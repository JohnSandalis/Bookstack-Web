<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.util.List, org.apache.commons.lang3.StringUtils, java.util.HashMap, java.text.SimpleDateFormat"%>
<%@ page import="bookstack.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="header.jsp" %>
    <meta name="description" content="Search book by ISBNs">
    <title>Enter Your Book</title>

    <script defer src="js/jquery.min.js"></script>
    <script defer src="js/ajax-select.js"></script>
    
    <link href="css/select2.css" rel="stylesheet" />
    <script defer src="js/select2.min.js"></script>
  </head>
  <body>
    <header class="header">
      <%@ include file="nav-menu.jsp" %>
    </header>

<% 
String isbn = request.getParameter("isbn");


String alertClass = "danger";
String alertText = "Invalid ISBN, please fill in the form manually";

HashMap<String, String> inputValues = new HashMap<String, String>();
SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

if (StringUtils.isNotBlank(isbn) && StringUtils.isNumeric(isbn) && 
                    ((isbn.length() == 10) || (isbn.length() == 13))) {
                      
  inputValues.put("isbn", isbn);
  alertText = "No book info, please fill in the form manually";
  Book book = null;

  // Search isbn in DB
  try {
    book = DatabaseUtils.getBookFromISBN(isbn);
  } catch (Exception e) {
    throw new Exception("DB exception: " + e.getMessage()); // TODO Handle exception
  }

  // Search isbn through API
  if (book == null) {
    try {
      book = BooksApiHandler.searchByIsbn(isbn);
    } catch (Exception e) {
      throw new Exception("API exception: " + e.getMessage()); // TODO Handle exception
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
    if (book.getPublishDate() != null) {
      inputValues.put("publishDate", dateFormatter.format(book.getPublishDate()));
    }
    inputValues.put("pageCount", String.valueOf(book.getPageCount()));
    inputValues.put("thumbnailUrl", book.getThumbnailUrl());
    inputValues.put("lang", book.getLang());
    inputValues.put("subjects", StringUtils.join(book.getSubjects(), ", "));
  }

}
%>
      <!-- Form -->
      <section class="form-section">
        <form method="POST" class="form" action="bookFormController.jsp" id="bookForm">
          <div class="form-container">
            <div class="back-btn-container">
              <ion-icon class="chevron-back-icon" name="chevron-back"></ion-icon>
              <button type="button" class="back-btn" onclick="history.back()">Back</button>
            </div>

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
                readonly
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("isbn"))%>"
                type="text"
                name="isbn"
                id="isbn"
                required
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
                readonly
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("title"))%>"
                type="text"
                name="title"
                id="title"
                required
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
              readonly
              <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("subtitle"))%>"
                type="text"
                name="subtitle"
                id="subtitle"
                required
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
                readonly
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("authors"))%>"
                type="text"
                name="author"
                required
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
                readonly
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("publisher"))%>"
                type="text"
                name="publisher"
                id="publisher"
                required
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
                readonly
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
                readonly
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("pageCount"))%>"
                type="number"
                name="page_count"
                id="page_count"
                required
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
                readonly
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
                readonly
                <%}%>
                value="<%=StringUtils.defaultString(inputValues.get("lang"))%>"
                type="text"
                name="language"
                required
                id="Language"
                placeholder="Language"
              />
              <span class="remove-arrow"></span>
            </div>
            
            <!-- Subjects -->
            <div class="custom-select form-group">
              <label for="subjects"
                ><ion-icon class="form-icon" name="menu"></ion-icon
              ></label>
              <select
                name="subjects"
                id="subjects"
                form="bookForm"
                multiple="multiple"
                required
                <%
                if (StringUtils.isNotBlank(inputValues.get("subjects"))) {
                %>
                disabled
                <%}%>
                >
                <%  
                  if (StringUtils.isNotBlank(inputValues.get("subjects"))) {
                    String[] allSubjects = inputValues.get("subjects").split(", ");
                    for (String subject : allSubjects) {%>
                      <option selected="selected" value="<%=subject%>"><%=subject%></option>
                  <%
                    }
                  }
                %>
              </select>
            </div>
            
            <!-- Submit button -->
            <button class="form-btn" type="submit" form="bookForm">Continue</button>
          </div>
        </form>
      </section>

      <%@ include file="footer.jsp" %>
  </body>
</html>
