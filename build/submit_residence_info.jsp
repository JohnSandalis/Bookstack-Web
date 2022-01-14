<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@ include file="header.jsp" %>
        <meta name="description" content="Registered users submit their information">
        <title>Address</title>
    </head>
    <body>
        <header class="header">
        <%@ include file="nav-menu.jsp" %>
        </header>
        <main>
            <section class="form-section">
                <form method="POST" class="form" action="servlet\SubmitResidenceServlet">
                  <div class="form-container">
                    <p class="form-title">Fill in your address</p>
                    <!--Address-->
                    <div class="form-group">
                      <label for="address">
                        <ion-icon class="form-icon" name="location"></ion-icon>
                      </label>
                      <input
                        type="text"
                        name="address"
                        id="address"
                        placeholder="Address"
                      />
                    </div>
                    <!--Floor-->
                    <div class="form-group">
                      <label for="floor"><ion-icon class="form-icon" name="layers"></ion-icon
                        ></label>
                      <input
                        type="number"
                        name="floor"
                        id="floor"
                        placeholder="Floor number"
                      />
                    </div>
                    <!--City-->
                    <div class="form-group">
                      <label for="city"><ion-icon class="form-icon" name="business"></ion-icon
                        ></label>
                      <input type="text" name="city" id="city" placeholder="City" />
                    </div>
                    <!--Region-->
                    <div class="form-group">
                      <label for="region"><ion-icon class="form-icon" name="map"></ion-icon
                        ></label>
                      <input
                        type="text"
                        name="region"
                        id="region"
                        placeholder="Region"
                      />
                    </div>
                    <!--Postal Code-->
                    <div class="form-group">
                      <label for="postal_code"
                        ><ion-icon class="form-icon" name="locate"></ion-icon
                          ></label>
                      <input
                        type="number"
                        name="postal_code"
                        id="postal_code"
                        placeholder="Postal code"
                      />
                    </div>
                    <!--Phone Number-->
                    <div class="form-group">
                      <label for="phone_number"
                        ><ion-icon class="form-icon" name="phone-portrait"></ion-icon
                          ></label>
                      <input
                        type="text"
                        name="phone_number"
                        id="phone_number"
                        placeholder="Phone number"
                      />
                    </div>
                    <!--Country-->
                    <div class="custom-select form-group">
                      <label for="country"
                        ><ion-icon class="form-icon" name="earth"></ion-icon
                      ></label>
                      <select class="select" id="country" name="country" required>
                        <option value="">Select Country:</option>
                        <%@ include file="country_selector.jsp" %>
                      </select>
                      <span class="remove-arrow"></span>
                    </div>
                    <!--Submit-->
                    <button class="form-btn" type="submit">Continue</button>
                </form>
              </section>
        </main>
        <%@ include file="footer.jsp" %>
    </body>
</html>