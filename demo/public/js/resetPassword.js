const url = location.href;
const params = url.split("?")[1];
const serverUrl = "http://localhost:3000/api";
let paramsObj = {};

$("#btn-minimal-resetpassword").click(function() {
  $("#minimal-resetpassword-message").text("");

  if($("#minimal-resetpassword-password").val() == "") {
        $("#minimal-resetpassword-message").text("Password is a required field.");
        $("#minimal-resetpassword-message").attr("class", "error-message");
        return;
    }

  if($("#minimal-resetpassword-password").val() !== $("#minimal-resetpassword-confirmpassword").val()) {
    $("#minimal-resetpassword-message").text("Passwords do not match!");
    $("#minimal-resetpassword-message").attr("class", "error-message");
    return;
  }

  let data = {
      "password" : $("#minimal-resetpassword-password").val(),    
      "resettoken" : paramsObj.vtoken
  }
  
  $.ajax({
      method: "PUT",
      data: JSON.stringify(data),
      url: serverUrl + "/login/resetpassword",
      contentType: "application/json",
      error: function(xhr) {
        let errorMessage;
        if (xhr.responseJSON) {
            errorMessage = xhr.responseJSON.Description;
        } else {
            errorMessage = xhr.statusText;
        }
          $("#minimal-resetpassword-message").text(errorMessage);
          $("#minimal-resetpassword-message").attr("class", "error-message");
      }
  }).done(function() { 
      $("#minimal-resetpassword-message").text("Password reset successful.");
      $("#minimal-resetpassword-message").attr("class", "success-message");
  });
});

if (params) {
  paramsObj = JSON.parse('{"' + decodeURI(params.replace(/&/g, "\",\"").replace(/=/g,"\":\"")) + '"}');

  if (paramsObj.vtype != "reset") {
    window.location.replace("index.html");
  }
} else {
  window.location.replace("index.html");
}
