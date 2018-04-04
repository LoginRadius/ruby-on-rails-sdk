# LoginRadius Ruby SDK


![Home Image](http://docs.lrcontent.com/resources/github/banner-1544x500.png)

## Introduction ##

LoginRadius Customer Registration wrapper provides access to LoginRadius Identity Management Platform API.

LoginRadius is an Identity Management Platform that simplifies user registration while securing data. LoginRadius Platform simplifies and secures your user registration process, increases conversion with Social Login that combines 30 major social platforms, and offers a full solution with Traditional Customer Registration. You can gather a wealth of user profile data from Social Login or Traditional Customer Registration. 

LoginRadius centralizes it all in one place, making it easy to manage and access. Easily integrate LoginRadius with all of your third-party applications, like MailChimp, Google Analytics, Livefyre and many more, making it easy to utilize the data you are capturing.

LoginRadius helps businesses boost user engagement on their web/mobile platform, manage online identities, utilize social media for marketing, capture accurate consumer data, and get unique social insight into their customer base.

Please visit [here](http://www.loginradius.com/) for more information.


## Contents ##

* [Demo](https://github.com/LoginRadius/ruby-on-rails-gem/tree/master/demo): It contains a demo of LoginRadius Flow.


## Documentation

* [Configuration](https://docs.loginradius.com/api/v2/sdk-libraries/ruby) - Everything you need to begin using the LoginRadius SDK.



# LoginRadius

Ruby wrapper for the LoginRadius API. Get social graph information and send messages using LoginRadius'
many social network clients!

Optional Asynchronous EventMachine friendly option!

## Installation

Add this line to your application's Gemfile:

 ```ruby 
 gem 'login_radius'
 ```

And then execute:
```ruby
$ bundle
```

Or install it yourself as:
```ruby
$ gem install login_radius
```

## Usage

Take a peek:
```ruby
  @Config = {
      :sitename => "<LOGINRADIUS_SITENAME>",
      :appkey => "<LOGINRADIUS_APPKEY>",
      :appsecret => "<LOGINRADIUS_APPSECRET>"
     }
    @loginradius = LoginRadius::RestRequest.new(@Config);
```
		