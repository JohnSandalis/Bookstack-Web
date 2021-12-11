<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.util.List"%>
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

<% String isbn = request.getParameter("isbn");
String title = null;
BookSubmission book = null;
if (isbn.length() > 0) {
    book = DatabaseUtils.getBookFromISBN(isbn);
}
if (book == null) {
    title = "Trade-in your book";
} else {
    title = "Book found";
}%>
      <!--Trade your books form-->
      <section class="form-section">
        <form method="POST" class="form">
          <div class="form-container">
            <p class="form-title"><%=title%></p>
            <div class="form-group">
              <label for="isbn">
                  <ion-icon class="form-icon" name="barcode"></ion-icon>
              </label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=isbn%>"
                type="text"
                name="isbn"
                id="isbn"
                placeholder="ISBN"
              />
              <%} else {%>
                <input type="text" name="isbn" id="isbn" placeholder="ISBN" />
              <%}%>
            </div>

            <div class="form-group">
              <label for="title"
                ><ion-icon class="form-icon" name="text"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=book.getBook().getTitle()%>"
                type="text"
                name="title"
                id="title"
                placeholder="Title"
              />
              <%} else {%>
                <input type="text" name="title" id="title" placeholder="Title" />
                <%}%>
            </div>

            <div class="form-group">
              <label for="subtitle"
                ><ion-icon class="form-icon" name="text-outline"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="Life, Liberty, and the Pursuit of Entrepreneurship"
                type="text"
                name="subtitle"
                id="subtitle"
                placeholder="Subtitle"
              />
              <%} else {%>
                <input
                type="text"
                name="subtitle"
                id="subtitle"
                placeholder="Subtitle"
              />
              <%}%>
            </div>

            <div class="form-group">
              <label for="author"
                ><ion-icon class="form-icon" name="person"></ion-icon
              ></label>
              <%if (book != null) {
                String authors = null;
                for (String s: book.getBook().getAuthors()) {
                    authors = s + ", ";
                }%>
                <input
                disabled
                value="<%=authors%>"
                type="text"
                name="subtitle"
                id="subtitle"
                placeholder="Subtitle"
              />
              <%} else {%>
                <input
                type="text"
                name="author"
                id="author"
                placeholder="Authors (ex Author1, Author2...)"
              />
              <%}%>
            </div>

            <div class="form-group">
              <label for="publisher"
                ><ion-icon class="form-icon" name="person-circle"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=book.getBook().getPublisher()%>"
                type="text"
                name="publisher"
                id="publisher"
                placeholder="Publisher"
              />
              <%} else {%>
                <input
                type="text"
                name="publisher"
                id="publisher"
                placeholder="Publisher"
              />
              <%}%>
            </div>

            <div class="form-group">
              <label for="publish_date"
                ><ion-icon class="form-icon" name="calendar"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=book.getBook().getPublish_date()%>"
                type="text"
                name="publish_date"
                id="publish_date"
                placeholder="Publish Date"
                onfocus="(this.type='date')"
                onblur="(this.type='text')"
              />
              <%} else {%>
                <input
                type="text"
                name="publish_date"
                id="publish_date"
                placeholder="Publish Date"
                onfocus="(this.type='date')"
                onblur="(this.type='text')"
              />
              <%}%>
            </div>

            <div class="form-group">
              <label for="page_count"
                ><ion-icon class="form-icon" name="documents"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=book.getBook().getPublish_date()%>"
                type="number"
                name="page_count"
                id="page_count"
                placeholder="Number of pages"
              />
              <%} else {%>
                <input
                type="number"
                name="page_count"
                id="page_count"
                placeholder="Number of pages"
              />
              <%}%>
            </div>

            <div class="form-group">
              <label for="thumbnail_url"
                ><ion-icon class="form-icon" name="code"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=book.getBook().getThumbnail_url()%>"
                type="text"
                name="thumbnail_url"
                id="thumbnail_url"
                placeholder="Cover Image url"
              />
              <%} else {%>
                <input
                type="text"
                name="thumbnail_url"
                id="thumbnail_url"
                placeholder="Cover Image url"
              />
              <%}%>
            </div>

            <div class="custom-select form-group">
              <label for="language"
                ><ion-icon class="form-icon" name="earth"></ion-icon
              ></label>
              <%if (book != null) {%>
                <input
                disabled
                value="<%=book.getBook().getLang()%>"
                type="text"
                name="language"
                id="Language"
                placeholder="Language"
              />
              <%} else {%>
                <select class="select" id="language" name="language" required>
                    <option value="">Select Language:</option>
                    <option value="en">English</option>
                    <option value="fr">French</option>
                    <option value="de">German</option>
                  </select>
              <%}%>
              
              <span class="remove-arrow"></span>
            </div>
            <div class="custom-select form-group">
              <label for="subject"
                ><ion-icon class="form-icon" name="menu"></ion-icon
              ></label>
              <%if (book != null) {
                String subjects = null;
                for (String s: book.getBook().getSubjects()) {
                    subjects = s + ", ";
                }%>
                <input
                disabled
                value="<%=subjects%>"
                type="text"
                name="subjects"
                id="subjects"
                placeholder="Subjects"
              />
              <%} else {%>
                <select class="select" id="subject" name="subject" required>
                    <option value="">Select Subject:</option>
                    <%List<String> subjects = DatabaseUtils.getBookSubjects(isbn);
                      int count = 0;
                      for (String i:subjects) {
                          count += 1;%>
                          <option value="<%=count%>"><%=i%></option>
                      <%}%>
                  </select>
              <%}%>
              <span class="remove-arrow"></span>
            </div>
            <a class="form-btn" href="#">Continue</a>
          </div>
        </form>
      </section>
      <!--Trade your books form-->
      <%@ include file="footer.jsp" %>
  </body>
</html>
