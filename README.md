# LoginRadius Ruby SDK


![Home Image](http://docs.lrcontent.com/resources/github/banner-1544x500.png)

## Introduction ##

LoginRadius Customer Registration wrapper provides access to LoginRadius Identity Management Platform API.

LoginRadius is an Identity Management Platform that simplifies user registration while securing data. LoginRadius Platform simplifies and secures your user registration process, increases conversion with Social Login that combines 30 major social platforms, and offers a full solution with Traditional Customer Registration. You can gather a wealth of user profile data from Social Login or Traditional Customer Registration. 

LoginRadius centralizes it all in one place, making it easy to manage and access. Easily integrate LoginRadius with all of your third-party applications, like MailChimp, Google Analytics, Livefyre and many more, making it easy to utilize the data you are capturing.

LoginRadius helps businesses boost user engagement on their web/mobile platform, manage online identities, utilize social media for marketing, capture accurate consumer data, and get unique social insight into their customer base.

Please visit [here](http://www.loginradius.com/) for more information.


## Contents ##

* [Demo](https://github.com/LoginRadius/ruby-on-rails-gem/tree/master/demo) - A simple demo application demonstrating the usage of this SDK.


## Documentation

* [Configuration](https://docs.loginradius.com/api/v2/sdk-libraries/ruby) - Everything you need to begin using the LoginRadius SDK.


# LoginRadius

Ruby wrapper for the LoginRadius API.

## Installation

Install the SDK by adding LoginRadius to your application's `Gemfile`.

 ```ruby
 gem 'login_radius'
 ```

Then, run `$ bundle`. A copy of the SDK can also be found on our [Github](https://github.com/LoginRadius/ruby-on-rails-gem/tree/master).

## Usage

Before using any of the functions available in the library, its corresponding module must first be instantiated:

Create `login_radius.rb` in `/config/initializers` with the following content: 

```ruby

require "login_radius"

loginradius_config = {
  :site_name => ENV["SITE_NAME"],
  :api_key => ENV["API_KEY"],
  :api_secret => ENV["API_SECRET"],
  :custom_api_domain => ENV["CUSTOM_API_DOMAIN"]
}

::LoginRadiusAccountClient = LoginRadius::Account.new(loginradius_config)
::LoginRadiusAuthenticationClient = LoginRadius::Authentication.new(loginradius_config)
::LoginRadiusCustomObjectClient = LoginRadius::CustomObjectManagement.new(loginradius_config)
::LoginRadiusMultiFactorClient = LoginRadius::MultiFactorAuthentication.new(loginradius_config)
::LoginRadiusPasswordlessClient = LoginRadius::PasswordlessLogin.new(loginradius_config)
::LoginRadiusRolesClient = LoginRadius::RolesManagement.new(loginradius_config)

```
Please note that you only have to initiate modules you need. 

The API key and secret can be obtained from the LoginRadius dashboard. Details on retrieving your key and secret can be found [here](https://docs.loginradius.com/api/v2/dashboard/get-api-key-and-secret#retrieve-your-api-key-and-secret).
