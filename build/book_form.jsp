<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
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
    <!--Book found form-->
    <section class="form-section">
        <form method="POST" class="form">
          <div class="form-container">
            <p class="form-title">Book found</p>
            <div class="form-group">
              <label for="isbn"
                ><ion-icon class="form-icon" name="barcode"></ion-icon
              ></label>
              <input
                disabled
                value="9780984358168"
                type="text"
                name="isbn"
                id="isbn"
                placeholder="ISBN"
              />
            </div>

            <div class="form-group">
              <label for="title"
                ><ion-icon class="form-icon" name="text"></ion-icon
              ></label>
              <input
                disabled
                value="Unscripted"
                type="text"
                name="title"
                id="title"
                placeholder="Title"
              />
            </div>

            <div class="form-group">
              <label for="subtitle"
                ><ion-icon class="form-icon" name="text-outline"></ion-icon
              ></label>
              <input
                disabled
                value="Life, Liberty, and the Pursuit of Entrepreneurship"
                type="text"
                name="subtitle"
                id="subtitle"
                placeholder="Subtitle"
              />
            </div>

            <div class="form-group">
              <label for="author"
                ><ion-icon class="form-icon" name="person"></ion-icon
              ></label>
              <input
                type="text"
                name="author"
                id="author"
                placeholder="Author"
              />
            </div>

            <div class="form-group">
              <label for="publisher"
                ><ion-icon class="form-icon" name="person-circle"></ion-icon
              ></label>
              <input
                disabled
                value="Viperion Corporation"
                type="text"
                name="publisher"
                id="publisher"
                placeholder="Publisher"
              />
            </div>

            <div class="form-group">
              <label for="publish_date"
                ><ion-icon class="form-icon" name="calendar"></ion-icon
              ></label>
              <input
                disabled
                value="2017-05-23"
                type="text"
                name="publish_date"
                id="publish_date"
                placeholder="Publish Date"
                onfocus="(this.type='date')"
                onblur="(this.type='text')"
              />
            </div>

            <div class="form-group">
              <label for="page_count"
                ><ion-icon class="form-icon" name="documents"></ion-icon
              ></label>
              <input
                disabled
                value="428"
                type="number"
                name="page_count"
                id="page_count"
                placeholder="Number of pages"
              />
            </div>

            <div class="form-group">
              <label for="thumbnail_url"
                ><ion-icon class="form-icon" name="code"></ion-icon
              ></label>
              <input
                disabled
                value="http://books.google.com/books/content?id=IIoaMQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
                type="text"
                name="thumbnail_url"
                id="thumbnail_url"
                placeholder="Cover Image url"
              />
            </div>

            <div class="custom-select form-group">
              <label for="language"
                ><ion-icon class="form-icon" name="earth"></ion-icon
              ></label>
              <select class="select" id="language" name="language" required>
                <option value="">Select Language:</option>
                <option value="en">English</option>
                <option value="fr">French</option>
                <option value="de">German</option>
              </select>
              <span class="remove-arrow"></span>
            </div>
            <div class="custom-select form-group">
              <label for="subject"
                ><ion-icon class="form-icon" name="menu"></ion-icon
              ></label>
              <select class="select disabled" id="subject" name="subject">
                <option value="2">Business</option>
              </select>
              <span class="remove-arrow disabled"></span>
            </div>
            <a class="form-btn" href="#">Continue</a>
          </div>
        </form>
      </section>
      <!--Book found form-->
      <!--Trade your books form-->
      <section class="form-section">
        <form method="POST" class="form">
          <div class="form-container">
            <p class="form-title">Trade-in your book</p>
            <div class="form-group">
              <label for="isbn"
                ><ion-icon class="form-icon" name="barcode"></ion-icon
              ></label>
              <input type="text" name="isbn" id="isbn" placeholder="ISBN" />
            </div>

            <div class="form-group">
              <label for="title"
                ><ion-icon class="form-icon" name="text"></ion-icon
              ></label>
              <input type="text" name="title" id="title" placeholder="Title" />
            </div>

            <div class="form-group">
              <label for="subtitle"
                ><ion-icon class="form-icon" name="text-outline"></ion-icon
              ></label>
              <input
                type="text"
                name="subtitle"
                id="subtitle"
                placeholder="Subtitle"
              />
            </div>

            <div class="form-group">
              <label for="author"
                ><ion-icon class="form-icon" name="person"></ion-icon
              ></label>
              <input
                type="text"
                name="author"
                id="author"
                placeholder="Author"
              />
            </div>

            <div class="form-group">
              <label for="publisher"
                ><ion-icon class="form-icon" name="person-circle"></ion-icon
              ></label>
              <input
                type="text"
                name="publisher"
                id="publisher"
                placeholder="Publisher"
              />
            </div>

            <div class="form-group">
              <label for="publish_date"
                ><ion-icon class="form-icon" name="calendar"></ion-icon
              ></label>
              <input
                type="text"
                name="publish_date"
                id="publish_date"
                placeholder="Publish Date"
                onfocus="(this.type='date')"
                onblur="(this.type='text')"
              />
            </div>

            <div class="form-group">
              <label for="page_count"
                ><ion-icon class="form-icon" name="documents"></ion-icon
              ></label>
              <input
                type="number"
                name="page_count"
                id="page_count"
                placeholder="Number of pages"
              />
            </div>

            <div class="form-group">
              <label for="thumbnail_url"
                ><ion-icon class="form-icon" name="code"></ion-icon
              ></label>
              <input
                type="text"
                name="thumbnail_url"
                id="thumbnail_url"
                placeholder="Cover Image url"
              />
            </div>

            <div class="custom-select form-group">
              <label for="language"
                ><ion-icon class="form-icon" name="earth"></ion-icon
              ></label>
              <select class="select" id="language" name="language" required>
                <option value="">Select Language:</option>
                <option value="en">English</option>
                <option value="fr">French</option>
                <option value="de">German</option>
              </select>
              <span class="remove-arrow"></span>
            </div>
            <div class="custom-select form-group">
              <label for="subject"
                ><ion-icon class="form-icon" name="menu"></ion-icon
              ></label>
              <select class="select" id="subject" name="subject" required>
                <option value="">Select Subject:</option>
                <option value="1">Action and Adventure</option>
                <option value="2">Business</option>
                <option value="3">Comic</option>
                <option value="4">Mystery</option>
              </select>
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
