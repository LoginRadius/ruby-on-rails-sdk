const serverUrl = "http://localhost:3000/api";
let update = {};

$("#btn-user-changepassword").click(function () {
  $("#user-changepassword-message").text("");

  if ($("#user-changepassword-oldpassword").val() == "" ||
    $("#user-changepassword-newpassword").val() == "") {
    $("#user-changepassword-message").text("Old Password/New Password are required fields.");
    $("#user-changepassword-message").attr("class", "error-message");
    return;
  }

  let data = {
    "oldpassword": $("#user-changepassword-oldpassword").val(),
    "newpassword": $("#user-changepassword-newpassword").val()
  }
  $.ajax({
    method: "PUT",
    url: serverUrl + "/profile/changepassword?auth=" + localStorage.getItem("LRTokenKey"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-changepassword-message").text(errorMessage);
      $("#user-changepassword-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-changepassword-message").text("Password successfully changed.");
    $("#user-changepassword-message").attr("class", "success-message");
  });
});

$("#btn-user-setpassword").click(function () {
  $("#user-setpassword-message").text("");

  if ($("#user-setpassword-password").val() == "") {
    $("#user-setpassword-message").text("Password is a required field.");
    $("#user-setpassword-message").attr("class", "error-message");
    return;
  }

  let data = {
    "password": $("#user-setpassword-password").val()
  }

  $.ajax({
    method: "PUT",
    url: serverUrl + "/profile/setpassword?uid=" + localStorage.getItem("LRUserID"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-setpassword-message").text(errorMessage);
      $("#user-setpassword-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-setpassword-message").text("Password successfully changed.");
    $("#user-setpassword-message").attr("class", "success-message");
  });
});

$("#btn-user-updateaccount").click(function () {
  $("#user-updateaccount-message").text("");

  let data = {};
  let dataFields = {
    "FirstName": $("#user-updateaccount-firstname").val().trim(),
    "LastName": $("#user-updateaccount-lastname").val().trim(),
    "About": $("#user-updateaccount-about").val().trim()
  }

  for (let key in dataFields) {
    if (dataFields[key] !== "") {
      data[key] = dataFields[key];
    } else {
      data[key] = update[key];
    }
  }

  $.ajax({
    method: "PUT",
    url: serverUrl + "/profile/update?uid=" + localStorage.getItem("LRUserID"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-updateaccount-message").text(errorMessage);
      $("#user-updateaccount-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-updateaccount-message").text("Account successfully updated.");
    $("#user-updateaccount-message").attr("class", "success-message");
    profileUpdate();
  });
});

$("#btn-user-createcustomobj").click(function () {
  $("#user-createcustomobj-message").text("");

  if ($("#user-createcustomobj-objectname").val().trim() == "" ||
    $("#user-createcustomobj-data").val().trim() == "") {
    $("#user-createcustomobj-message").text("Object Name/Data are required fields.");
    $("#user-createcustomobj-message").attr("class", "error-message");
    return;
  }

  let data;

  try {
    data = JSON.parse($("#user-createcustomobj-data").val());
  } catch (e) {
    $("#user-createcustomobj-message").text("Please input a valid JSON object in the data field.");
    $("#user-createcustomobj-message").attr("class", "error-message");
    return;
  }

  $.ajax({
    method: "POST",
    url: serverUrl + "/customobj?object_name=" + $("#user-createcustomobj-objectname").val() + "&auth=" + localStorage.getItem("LRTokenKey"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-createcustomobj-message").text(errorMessage);
      $("#user-createcustomobj-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-createcustomobj-message").text("Object successfully created.");
    $("#user-createcustomobj-message").attr("class", "success-message");
  });
});

$("#btn-user-updatecustomobj").click(function () {
  $("#user-updatecustomobj-message").text("");

  if ($("#user-updatecustomobj-objectname").val().trim() == "" ||
    $("#user-updatecustomobj-objectrecordid").val().trim() == "" ||
    $("#user-updatecustomobj-data").val().trim() == "") {
    $("#user-updatecustomobj-message").text("Object Name/Object ID/Data are required fields.");
    $("#user-updatecustomobj-message").attr("class", "error-message");
    return;
  }

  let data;

  try {
    data = JSON.parse($("#user-updatecustomobj-data").val());
  } catch (e) {
    $("#user-updatecustomobj-message").text("Please input a valid JSON object in the data field.");
    $("#user-updatecustomobj-message").attr("class", "error-message");
    return;
  }

  $.ajax({
    method: "PUT",
    url: serverUrl + "/customobj?object_name=" + $("#user-updatecustomobj-objectname").val() + "&auth=" + localStorage.getItem("LRTokenKey") +
      "&object_id=" + $("#user-updatecustomobj-objectrecordid").val(),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-updatecustomobj-message").text(errorMessage);
      $("#user-updatecustomobj-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-updatecustomobj-message").text("Object successfully updated.");
    $("#user-updatecustomobj-message").attr("class", "success-message");
  });
});

$("#btn-user-deletecustomobj").click(function () {
  $("#user-deletecustomobj-message").text("");

  if ($("#user-deletecustomobj-objectname").val().trim() == "" ||
    $("#user-deletecustomobj-objectrecordid").val().trim() == "") {
    $("#user-deletecustomobj-message").text("Object Name/Object ID are required fields.");
    $("#user-deletecustomobj-message").attr("class", "error-message");
    return;
  }

  $.ajax({
    method: "DELETE",
    url: serverUrl + "/customobj?object_name=" + $("#user-deletecustomobj-objectname").val() + "&auth=" + localStorage.getItem("LRTokenKey") +
      "&object_id=" + $("#user-deletecustomobj-objectrecordid").val(),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-deletecustomobj-message").text(errorMessage);
      $("#user-deletecustomobj-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-deletecustomobj-message").text("Custom object deleted successfully.");
    $("#user-deletecustomobj-message").attr("class", "success-message");
  });
});

$("#btn-user-getcustomobj").click(function () {
  $("#user-getcustomobj-message").text("");

  if ($("#user-getcustomobj-objectname").val().trim() == "") {
    $("#user-getcustomobj-message").text("Object Name is a required field.");
    $("#user-getcustomobj-message").attr("class", "error-message");
    return;
  }

  $.ajax({
    method: "GET",
    cache: false,
    url: serverUrl + "/customobj?object_name=" + $("#user-getcustomobj-objectname").val() + "&auth=" + localStorage.getItem("LRTokenKey"),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $('#table-customobj tr').remove();
      $("#user-getcustomobj-message").text(errorMessage);
      $("#user-getcustomobj-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    $('#table-customobj tr').remove();
    $("#user-getcustomobj-message").text("");
    $("#user-getcustomobj-message").attr("class", "success-message");
    $('<tr>' +
      '<th>Object ID</th><th>Custom Object</th>' +
      '<tr>').appendTo("#table-customobj > tbody:last-child");

    for (let i = 0; i < ret.data.length; i++) {
      $("<tr><td>" + ret.data[i].Id + "</td></tr>").appendTo("#table-customobj > tbody:last-child");
      $("<td>", {
        text: JSON.stringify(ret.data[i].CustomObject)
      }).appendTo("#table-customobj > tbody:last-child > tr:last-child");
    }
  });
});

$("#btn-user-mfa-resetgoogle").click(function () {
  $("#user-mfa-message").text("");

  let data = {
    "googleauthenticator": true
  }

  $.ajax({
    method: "DELETE",
    url: serverUrl + "/mfa/google?auth=" + localStorage.getItem("LRTokenKey"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-mfa-message").text(errorMessage);
      $("#user-mfa-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-mfa-message").text("Google Authenticator settings reset.");
    $("#user-mfa-message").attr("class", "success-message");
  });
});

$("#btn-user-mfaenable").click(function () {
  $("#user-mfaenable-message").text("");

  $.ajax({
    method: "GET",
    url: serverUrl + "/mfa/validate?auth=" + localStorage.getItem("LRTokenKey"),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-mfaenable-message").text(errorMessage);
      $("#user-mfaenable-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    if (ret.IsGoogleAuthenticatorVerified === false) {
      $("#user-mfaenable-qrcode").append('<img src="' + ret.QRCode + '">');
    }
    $("#user-mfaenable").html('<table><tbody><tr>' +
      '<td>Google Authenticator Code: </td><td><input name="googleauth" type="text" id="user-mfaenable-googleauth"></td>' +
      '</tr></tbody></table>' +
      '<button id="btn-user-mfaenable-googleauth">Submit</button>');
  });
});

$("#user-mfaenable").on("click", "#btn-user-mfaenable-googleauth", function () {
  $("#user-mfaenable-message").text("");

  if ($("#user-mfaenable-googleauth").val().trim() == "") {
    $("#user-mfaenable-message").text("Google Authenticator Code is a required field.");
    $("#user-mfaenable-message").attr("class", "error-message");
    return;
  }

  let data = {
    "googleauthenticatorcode": $("#user-mfaenable-googleauth").val()
  }

  $.ajax({
    method: "PUT",
    url: serverUrl + "/mfa/google/enable?auth=" + localStorage.getItem("LRTokenKey"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-mfaenable-message").text(errorMessage);
      $("#user-mfaenable-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-mfaenable-message").text("MFA has been enabled.");
    $("#user-mfaenable-message").attr("class", "success-message");
  });
});

$("#btn-user-createrole").click(function () {
  $("#user-createrole-message").text("");

  if ($("#user-roles-createrole").val().trim() == "") {
    $("#user-createrole-message").text("Role is a required field.");
    $("#user-createrole-message").attr("class", "error-message");
    return;
  }

  let data = {
    "roles": [{
      "Name": $("#user-roles-createrole").val().trim()
    }]
  }

  $.ajax({
    method: "POST",
    url: serverUrl + "/roles",
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-createrole-message").text(errorMessage);
      $("#user-createrole-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-createrole-message").text("Role created successfully.");
    $("#user-createrole-message").attr("class", "success-message");
    roleUpdate();
  });
});

$("#btn-user-deleterole").click(function () {
  $("#user-deleterole-message").text("");

  if ($("#user-roles-deleterole").val().trim() == "") {
    $("#user-deleterole-message").text("Role is a required field.");
    $("#user-deleterole-message").attr("class", "error-message");
    return;
  }

  $.ajax({
    method: "DELETE",
    url: serverUrl + "/roles?role=" + $("#user-roles-deleterole").val().trim(),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-deleterole-message").text(errorMessage);
      $("#user-deleterole-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-deleterole-message").text("Role deleted successfully.");
    $("#user-deleterole-message").attr("class", "success-message");
    roleUpdate();
  });
});

$("#btn-user-assignrole").click(function () {
  $("#user-assignrole-message").text("");

  if ($("#user-roles-assignrole").val().trim() == "") {
    $("#user-assignrole-message").text("Role is a required field.");
    $("#user-assignrole-message").attr("class", "error-message");
    return;
  }

  let data = {
    "Roles": [
      $("#user-roles-assignrole").val().trim()
    ]
  }

  $.ajax({
    method: "PUT",
    url: serverUrl + "/roles?uid=" + localStorage.getItem("LRUserID"),
    data: JSON.stringify(data),
    contentType: "application/json",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-assignrole-message").text(errorMessage);
      $("#user-assignrole-message").attr("class", "error-message");
    }
  }).done(function () {
    $("#user-assignrole-message").text("Role added to current user successfully.");
    $("#user-assignrole-message").attr("class", "success-message");
    roleUpdate();
  });
});

$("#menu-logout").click(function () {
  localStorage.removeItem("LRTokenKey");
  localStorage.removeItem("LRUserID");
  window.location.replace("index.html");
});

let profileUpdate = function () {
  if (localStorage.getItem("LRTokenKey") === null) {
    window.location.replace("index.html");
    return;
  }

  $.ajax({
    method: "GET",
    cache: false,
    url: serverUrl + "/profile?auth=" + localStorage.getItem("LRTokenKey"),
    error: function () {
      localStorage.removeItem("LRTokenKey");
      localStorage.removeItem("LRUserID");
      window.location.replace("index.html");
    }
  }).done(function (ret) {
    if (ret.ThumbnailImageUrl) {
      $("#profile-image").html("<img src='" + ret.ThumbnailImageUrl + "'>");
    } else {
      $("#profile-image").html("<img src='./user-blank.png'>");
    }
    $("#profile-name").html("<b>" + (ret.FullName ? ret.FullName : "") + "</b>");
    $("#profile-provider").text("Provider: " + (ret.Provider ? ret.Provider : ""));
    $("#profile-email").text((ret.Email && ret.Email[0] && ret.Email[0].Value ? ret.Email[0].Value : ""));
    $("#profile-lastlogin").text("Last Login Date: " + (ret.LastLoginDate ? ret.LastLoginDate : ""));
    update.FirstName = ret.FirstName;
    update.LastName = ret.LastName;
    update.About = ret.About;
  });
}

let roleUpdate = function () {
  $("#user-allroles-message").text("");
  $("#user-userroles-message").text("");

  $.ajax({
    method: "GET",
    cache: false,
    url: serverUrl + "/roles",
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-allroles-message").text(errorMessage);
      $("#user-allroles-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    $('#table-allroles tr:not(:first)').remove();
    if (ret.data) {
      for (let i = 0; i < ret.data.length; i++) {
        $("<tr></tr>").appendTo("#table-allroles > tbody:last-child");
        $("<td>", {
          text: ret.data[i].Name
        }).appendTo('#table-allroles > tbody:last-child > tr:last-child');
      }
    }
  });

  $.ajax({
    method: "GET",
    cache: false,
    url: serverUrl + "/roles/get?uid=" + localStorage.getItem("LRUserID"),
    error: function (xhr) {
      let errorMessage;
      if (xhr.responseJSON) {
        errorMessage = xhr.responseJSON.Description;
      } else {
        errorMessage = xhr.statusText;
      }
      $("#user-userroles-message").text(errorMessage);
      $("#user-userroles-message").attr("class", "error-message");
    }
  }).done(function (ret) {
    $('#table-userroles tr:not(:first)').remove();
    if (ret.Roles) {
      for (let i = 0; i < ret.Roles.length; i++) {
        $("<tr></tr>").appendTo("#table-userroles > tbody:last-child");
        $("<td>", {
          text: ret.Roles[i]
        }).appendTo('#table-userroles > tbody:last-child > tr:last-child');
      }
    }
  });
}

let script = $(
  '<script type="text/html" id="loginradiuscustom_tmpl_link">' +
  '<# if(isLinked) { #>' +
  '<div class="lr-linked">' +
  '<a class="lr-provider-label" href="javascript:void(0)" title="<#= Name #>" alt="Connected" onclick=\'return LRObject.util.unLinkAccount(\"<#= Name.toLowerCase() #>\",\"<#= providerId #>\")\'><#=Name#> is connected | Delete</a>' +
  '</div>' +
  '<# }  else {#>' +
  '<div class="lr-unlinked">' +
  '<a class="lr-provider-label" href="javascript:void(0)" onclick="return LRObject.util.openWindow(\'<#= Endpoint #>\');" title="<#= Name #>" alt="Sign in with <#=Name#>">' +
  '<#=Name#></a></div>' +
  '<# } #>' +
  '</script>'
);

$("#script-accountlinking").append(script);

let la_options = {};
la_options.container = "interfacecontainerdiv";
la_options.templateName = 'loginradiuscustom_tmpl_link';
la_options.onSuccess = function () {
  $("#interfacecontainerdiv").empty();
  LRObject.util.ready(function () {
    LRObject.init("linkAccount", la_options);
  });
}
la_options.onError = function (errors) {
  $("#user-accountlinking-message").text(errors[0].Description);
  $("#user-accountlinking-message").attr("class", "error-message");
}

let unlink_options = {};
unlink_options.onSuccess = function () {
  $("#interfacecontainerdiv").empty();
  LRObject.util.ready(function () {
    LRObject.init("linkAccount", la_options);
  });
}
unlink_options.onError = function (errors) {
  $("#user-accountlinking-message").text(errors[0].Description);
  $("#user-accountlinking-message").attr("class", "error-message");
}

LRObject.util.ready(function () {
  LRObject.init("linkAccount", la_options);
  LRObject.init("unLinkAccount", unlink_options);
});

profileUpdate();
roleUpdate();