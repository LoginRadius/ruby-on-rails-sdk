var commonOptions = {};
commonOptions.apiKey = "<ApiKey>";
commonOptions.appName = "<AppName>";
commonOptions.hashTemplate = true;
commonOptions.sott = "<SOTT>";
commonOptions.formValidationMessage = true;
var path = window.location.href;
commonOptions.verificationUrl = path.slice(0, path.lastIndexOf('/')).concat("/emailverification.html");
commonOptions.resetPasswordUrl = path.slice(0, path.lastIndexOf("/")).concat("/resetpassword.html");
var LRObject = new LoginRadiusV2(commonOptions);