const url = location.href;
const params = url.split("?")[1];
const serverUrl = "http://localhost:3000/api";
let paramsObj = {};

if (params) {
    paramsObj = JSON.parse('{"' + decodeURI(params.replace(/&/g, "\",\"").replace(/=/g,"\":\"")) + '"}');

    if (paramsObj.vtype === "emailverification") {
        $.ajax({
            method: "GET",
            url: serverUrl + "/register/verify/email?verification_token=" + paramsObj.vtoken,
            contentType: "application/json",
            error: function(xhr) {
                let errorMessage;
                if (xhr.responseJSON) {
                    errorMessage = xhr.responseJSON.Description;
                } else {
                    errorMessage = xhr.statusText;
                }
                $("#minimal-verification-message").text(errorMessage);
                $("#minimal-verification-message").attr("class", "error-message");
            }
        }).done(function() { 
            $("#minimal-verification-message").text("Email successfully verified.");
            $("#minimal-verification-message").attr("class", "success-message");
        });
    } else if (paramsObj.vtype === "oneclicksignin") {
        $.ajax({
            method: "GET",
            url: serverUrl + "/login/passwordless/auth?verification_token=" + paramsObj.vtoken,
            contentType: "application/json",
            error: function(xhr) {
                let errorMessage;
                if (xhr.responseJSON) {
                    errorMessage = xhr.responseJSON.Description;
                } else {
                    errorMessage = xhr.statusText;
                }
                $("#minimal-verification-message").text(errorMessage);
                $("#minimal-verification-message").attr("class", "error-message");
            }
        }).done(function(ret) {
            localStorage.setItem("LRTokenKey", ret.access_token);
            localStorage.setItem("LRUserID", ret.Profile.Uid);
            window.location.replace("profile.html");
        });
    } else {
        window.location.replace("index.html");
    }
} else {
    window.location.replace("index.html");
}
