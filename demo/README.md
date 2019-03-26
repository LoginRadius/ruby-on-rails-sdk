### LoginRadius Rails Demo

A simple demo web application with a Rails server backend (using the LoginRadius Ruby SDK). The following features are included:

* Traditional Email Login
* Multi-Factor Email Login
* Passwordless Login
* Social Login
* Registration
* Email Verification
* Forgot Password
* Reset Password
* Change Password
* Set Password
* Update Account
* Multi-Factor Configuration
* Account Linking
* Custom Object Management
* Roles Management

A JavaScript based front-end implementation using Loginradius Login Screen is also provided with the demo. For more information please visit this [link](https://www.loginradius.com/docs/api/v2/deployment/demos/login-screen).

#### Prerequisites
You must have Ruby and Rails set up in order to run this demo project. 

Follow [this](https://www.ruby-lang.org/en/documentation/installation/) guide to install Ruby, and [this](https://guides.rubyonrails.org/v5.0/getting_started.html#installing-rails) guide to install Rails. 

##### Set up

1. Run `bundle install`
2. Run `bundle exec figaro install`, then configure the generated `/config/application.yml` with your credentials; an example is provided in  `config/application.yml.example`
3. Run the server using `rails server`

To configure the login screen implementation, create `options.js` in `/public/js` based on the example provided in `/public/options.js.sample` 
