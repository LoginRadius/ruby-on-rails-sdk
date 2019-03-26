var options = {
  redirecturl: {
    afterlogin: "http://localhost:3000",
    afterreset: "http://localhost:3000",
  },
  socialsquarestyle: false,
  pagesshown: ["login", "signup", "forgotpassword"]
};

LRObject.util.ready(function () {
  LRObject.loginScreen("loginscreen-container", options)
});