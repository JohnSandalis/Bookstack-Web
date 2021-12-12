<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="header.jsp" %>
    <title>Bookstack</title>
  </head>
  <body>
    <header class="header bg-light">
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

    <main>
      <section class="itm-preview-section">
        <div class="itm-preview-container">
          <div class="itm-img-col">
            <div class="img-box-preview">
              <img
                class="itm-img-preview"
                src="https://images-na.ssl-images-amazon.com/images/I/71iud2Nk92L.jpg"
                alt="book cover"
              />
            </div>
          </div>
          <div class="itm-description-col">
            <p class="itm-isbn">ISBN: 9780984358168</p>
            <h1 class="itm-title-preview">Unscripted</h1>
            <p class="itm-subtitle">
              Life, Liberty, and the Pursuit of Entrepreneurship
            </p>
            <p class="itm-preview">Authors Name: M. J. Demarco</p>
            <p class="itm-preview">Publisher: Viperion Corporation</p>
            <p class="itm-preview">Publish Date: 2017-05-23</p>
            <p class="itm-preview">Page Count: 428</p>
            <p class="itm-preview">Subject: Business</p>
            <p class="itm-preview">Language: en</p>
            <div class="itm-credits-preview">
              <ion-icon class="credits-icon" name="cash-outline"></ion-icon>
              <span class="itm-credits">300</span>
            </div>
            <a class="btn btn-sm" href="#">Acquire</a>
          </div>
        </div>
      </section>
    </main>

    <%@ include file="footer.jsp" %>

  </body>
</html>
