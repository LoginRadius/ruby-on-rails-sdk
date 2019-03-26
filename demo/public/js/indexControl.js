const serverUrl = "http://localhost:3000/api";
let multiFactorAuthToken;

let custom_interface_option = {};
custom_interface_option.templateName = 'loginradiuscustom_tmpl';
LRObject.util.ready(function () {
  LRObject.customInterface(".interfacecontainerdiv", custom_interface_option);
});

let sl_options = {};
sl_options.onSuccess = function (response) {
  localStorage.setItem("LRTokenKey", response.access_token);
  localStorage.setItem("LRUserID", response.Profile.Uid);
  window.location.replace("profile.html");
};
sl_options.onError = function (errors) {
  let errorMessage = "";
  errors.forEach(function (err) {
    if (err.Description) {
      errorMessage = errorMessage + err.Description + " ";
    }
  });
  $("#sociallogin-message").text(errorMessage);
  $("#sociallogin-message").attr("class", "error-message");
};
sl_options.container = "sociallogin-container";

LRObject.util.ready(function () {
  LRObject.init('socialLogin', sl_options);
});

$("#btn-minimal-login").click(function () {
  $("#minimal-login-message").text("");

  if ($("#minimal-login-email").val().trim() == "" ||
    $("#minimal-login-password").val() == "") {
    $("#minimal-login-message").text("Email Address/Password are required fields.");
    $("#minimal-login-message").attr("class", "error-message");
    return;
  }

  data = {
    "Email": $("#minimal-login-email").val(),
    "Password": $("#minimal-login-password").val()
  }
  $.ajax({
    method: "POST",
    data: JSON.stringify(data),
    url: serverUrl + "/login/email?verification_url=" + commonOptions.verificationUrl,
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#minimal-login-message").text(errorMessage);
      $("#minimal-login-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    localStorage.setItem("LRTokenKey", ret.access_token);
    localStorage.setItem("LRUserID", ret.Profile.Uid);
    window.location.replace("profile.html");
  });
});

$("#btn-minimal-mfalogin-next").click(function () {
  $("#minimal-mfalogin-message").text("");

  if ($("#minimal-mfalogin-email").val().trim() == "" ||
    $("#minimal-mfalogin-password").val() == "") {
    $("#minimal-mfalogin-message").text("Email Address/Password are required fields.");
    $("#minimal-mfalogin-message").attr("class", "error-message");
    return;
  }

  data = {
    "Email": $("#minimal-mfalogin-email").val(),
    "Password": $("#minimal-mfalogin-password").val()
  }
  $.ajax({
    method: "POST",
    data: JSON.stringify(data),
    url: serverUrl + "/mfa/login/email?verification_url=" + commonOptions.verificationUrl,
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#minimal-mfalogin-message").text(errorMessage);
      $("#minimal-mfalogin-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    $("#minimal-mfalogin-message").text("");
    if (ret.SecondFactorAuthentication) {
      if (ret.SecondFactorAuthentication.IsGoogleAuthenticatorVerified === false) {
        $("#minimal-mfalogin-qrcode").append('<img src="' + ret.SecondFactorAuthentication.QRCode + '">');
      }
      $("#minimal-mfalogin-next")
        .html('<table><tbody><tr>' +
          '<td>Google Authenticator Code: </td><td><input type="text" id="minimal-mfalogin-googlecode"></td>' +
          '</tr></tbody></table>' +
          '<button id="btn-minimal-mfalogin-login">Login</button>');
      multiFactorAuthToken = ret.SecondFactorAuthentication.SecondFactorAuthenticationToken;
    } else {
      localStorage.setItem("LRTokenKey", ret.access_token);
      localStorage.setItem("LRUserID", ret.Profile.Uid);
      window.location.replace("profile.html");
    }
  });
});

$("#minimal-mfalogin-next").on('click', "#btn-minimal-mfalogin-login", function () {
  $("#minimal-mfalogin-message").text("");

  if ($("#minimal-mfalogin-googlecode").val().trim() == "") {
    $("#minimal-mfalogin-message").text("Google Authenticator Code is a required field.");
    $("#minimal-mfalogin-message").attr("class", "error-message");
    return;
  }

  data = {
    "googleauthenticatorcode": $("#minimal-mfalogin-googlecode").val()
  }

  $.ajax({
    method: "PUT",
    data: JSON.stringify(data),
    url: serverUrl + "/mfa/google/auth?multi_factor_auth_token=" + multiFactorAuthToken,
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#minimal-mfalogin-message").text(errorMessage);
      $("#minimal-mfalogin-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    localStorage.setItem("LRTokenKey", ret.access_token);
    localStorage.setItem("LRUserID", ret.Profile.Uid);
    window.location.replace("profile.html");
  });
});

$("#btn-minimal-pwless").click(function () {
  $("#minimal-pwless-message").text("");

  if ($("#minimal-pwless-email").val().trim() == "") {
    $("#minimal-pwless-message").text("Email Address is a required field.");
    $("#minimal-pwless-message").attr("class", "error-message");
    return;
  }

  $.ajax({
    method: "GET",
    url: serverUrl + "/login/passwordless?email=" + $("#minimal-pwless-email").val() + "&verification_url=" + commonOptions.verificationUrl,
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#minimal-pwless-message").text(errorMessage);
      $("#minimal-pwless-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#minimal-pwless-message").text("Check your email for the login link.");
    $("#minimal-pwless-message").attr("class", "success-message");
  });
});

$("#btn-minimal-signup").click(function () {
  $("#minimal-signup-message").text("");

  if ($("#minimal-signup-email").val().trim() == "" ||
    $("#minimal-signup-password").val() == "") {
    $("#minimal-signup-message").text("Email Address/Password are required fields.");
    $("#minimal-signup-message").attr("class", "error-message");
    return;
  }

  if ($("#minimal-signup-password").val() != $("#minimal-signup-confirmpassword").val()) {
    $("#minimal-signup-message").text("Passwords do not match!");
    $("#minimal-signup-message").attr("class", "error-message");
    return;
  }
  let data = {
    "Email": [{
      "Type": "Primary",
      "Value": $("#minimal-signup-email").val()
    }],
    "Password": $("#minimal-signup-password").val()
  }

  $.ajax({
    method: "POST",
    url: serverUrl + "/register?verification_url=" + commonOptions.verificationUrl,
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#minimal-signup-message").text(errorMessage);
      $("#minimal-signup-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#minimal-signup-message").text("Check your email to verify your account.");
    $("#minimal-signup-message").attr("class", "success-message");
  });
});

$("#btn-minimal-forgotpassword").click(function () {
  $("#minimal-forgotpassword-message").text("");

  if ($("#minimal-forgotpassword-email").val().trim() == "") {
    $("#minimal-forgotpassword-message").text("Email Address is a required field.");
    $("#minimal-forgotpassword-message").attr("class", "error-message");
    return;
  }

  data = {
    "Email": $("#minimal-forgotpassword-email").val()
  }

  $.ajax({
    method: "POST",
    data: JSON.stringify(data),
    url: serverUrl + "/forgotpassword?reset_password_url=" + commonOptions.resetPasswordUrl,
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#minimal-forgotpassword-message").text(errorMessage);
      $("#minimal-forgotpassword-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#minimal-forgotpassword-message").text("Check your email to start the password reset process.");
    $("#minimal-forgotpassword-message").attr("class", "success-message");
  });
});

function checkSession() {
  if (localStorage.getItem("LRTokenKey") !== null) {
    window.location.replace("profile.html");
    if (localStorage.getItem("lr-user-uid")) {
      localStorage.setItem('LRUserID', localStorage.getItem("lr-user-uid"));
      localStorage.removeItem("lr-user-uid");
    }
    return;
  }
}

checkSession();