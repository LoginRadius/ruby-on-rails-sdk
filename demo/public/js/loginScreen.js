var options = {
  redirecturl: {
    afterlogin: "http://127.0.0.1:3000",
    afterreset: "http://127.0.0.1:3000",
  },
  socialsquarestyle: false,
  pagesshown: ["login", "signup", "forgotpassword"]
};

LRObject.util.ready(function () {
  LRObject.loginScreen("loginscreen-container", options)
});