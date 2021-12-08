<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="header.jsp" %>
    <meta name="description" content="Bookstack is an online platform where you can trade books without having to search for someone with mutual interests. You can send your used books to us, receive credits and acquire books.">
    <title>Bookstack</title>
  </head>
  <body>
    <header class="header bg-light">
      <a href="index.jsp" class="logo">Bookstack</a>

      <nav class="main-nav">
        <ul class="main-nav-list">
          <li><a class="main-nav-link" href="#">Home</a></li>
          <li><a class="main-nav-link" href="browse.jsp">Browse</a></li>
          <li><a class="main-nav-link" href="account.jsp">Account</a></li>
        </ul>
      </nav>

      <button class="btn-mobile-nav">
        <ion-icon class="icon-mobile-nav" name="menu-outline"></ion-icon>
        <ion-icon class="icon-mobile-nav" name="close-outline"></ion-icon>
      </button>
    </header>

    <main>
      <section class="section-hero">
        <div class="hero">
          <div class="hero-text-box">
            <h1 class="heading-primary">
              Trade books online by letting us find someone with the next read
              for you
            </h1>
            <p class="hero-text">
              We love reading books. Lots of them. But there always comes a time
              where you are not sure what your next read is going to be. That is
              where trading books comes into handy. <br />
              <br />
              Do you have books laying around? Through Bookstack you can
              trade-in books, get rewarded with points and acquire new ones
              without having to find someone with mutual interests.
            </p>
          </div>
          <div class="hero-img-box">
            <img
              src="images/hero.jpg"
              class="hero-img"
              alt="Person reading book"
            />
          </div>
        </div>
        <div class="books-traded-box">
          <span class="books-traded"
            >So far <strong>21.350</strong> books have been traded through
            Bookstack</span
          >
        </div>
      </section>

      <section class="section-how-it-works">
        <div class="container">
          <span class="subheading">How it works</span>
          <h2 class="heading-primary">Trade books with the following steps</h2>
        </div>

        <div class="container grid grid--2-cols grid--center-v">
          <!-- STEP 01 -->
          <div class="step-text-box">
            <p class="step-number">01</p>
            <h3 class="heading-secondary">Submit your book</h3>
            <p class="step-description">
              After creating an account you can trade-in one of your books by
              filling in a new entry form. Simply type in your book's ISBN (10
              or 13 digit code usually on the back cover). Then the book
              information should be returned together with the amount of credits
              you will earn.
            </p>
          </div>

          <div class="step-img-box">
            <img
              src="images/submit.jpg"
              class="step-img"
              alt="Person typing into his computer"
            />
          </div>

          <!-- STEP 02 -->
          <div class="step-img-box">
            <img
              src="images/shipping.jpg"
              class="step-img"
              alt="Delivery truck in traffic"
            />
          </div>

          <div class="step-text-box">
            <p class="step-number">02</p>
            <h3 class="heading-secondary">Ship your book to our warehouse</h3>
            <p class="step-description">
              After submitting your book on our platform, you are kindly asked
              to send it to our warehouse. This way, we can guarantee that every
              book is in at least an average condition and also so that we can
              handle the shipping to the next owner.
            </p>
          </div>

          <!-- STEP 03 -->
          <div class="step-text-box">
            <p class="step-number">03</p>
            <h3 class="heading-secondary">Acquire Books</h3>
            <p class="step-description">
              As soon as your book arrives at our wharehouse and we make sure
              its condition is decent, you will be rewarded with the
              predetermined credits. Now you can acquire any book that you like
              from the browse section if you have enough credits. Fill in your
              address and we will ship it right to you.
            </p>
          </div>

          <div class="step-img-box">
            <img
              src="images/books.jpg"
              class="step-img"
              alt="Person typing into his computer"
            />
          </div>
        </div>
      </section>
    </main>
    <%@ include file="footer.jsp" %>
  </body>
</html>
