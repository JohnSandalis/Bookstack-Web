var check = function() {
    if (document.getElementById('password').value ==
      document.getElementById('confirm_password').value) {
      document.getElementById('password-message').innerHTML = "";
    } else {
      document.getElementById('password-message').innerHTML = "Password and confirm do not match";
      document.getElementById('password-message').style.cssText = "font-size: 1.6rem; padding-top: 0.1cm;"
      + " padding-bottom: 0cm; color: #a94442;";
    }
  }