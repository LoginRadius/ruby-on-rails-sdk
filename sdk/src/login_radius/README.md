## Installation

Install the SDK by adding LoginRadius to your application's `Gemfile`.

```ruby
gem 'login_radius'
```

Then, run `$ bundle`. A copy of the SDK can also be found on our [Github](https://github.com/LoginRadius/ruby-on-rails-gem/tree/master).

## Quickstart Guide

Before using any of the functions available in the library, its corresponding module must first be instantiated:

```ruby
# Account Module
::LoginRadiusAccountClient = LoginRadius::Account.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Authentication Module
::LoginRadiusAuthenticationClient = LoginRadius::Authentication.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret (optional, only needed for auth_user_registration_by_email)>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Configuration Module
::LoginRadiusConfigurationClient = LoginRadius::Configuration.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Custom Object Management Module
::LoginRadiusCustomObjectClient = LoginRadius::CustomObjectManagement.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Custom Registration Data Module
::LoginRadiusCustomRegistrationDataClient = LoginRadius::CustomRegistrationData.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Multi Factor Authentication Module
::LoginRadiusMultiFactorClient = LoginRadius::MultiFactorAuthentication.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# One Touch Login Module
::LoginRadiusOneTouchClient = LoginRadius::OneTouchLogin.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Passwordless Login Module
::LoginRadiusPasswordlessClient = LoginRadius::PasswordlessLogin.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Phone Authentication Module
::LoginRadiusPhoneClient = LoginRadius::PhoneAuthentication.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret (optional, only needed for user registration and remove phone ID)>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Roles Management Module
::LoginRadiusRolesClient = LoginRadius::RolesManagement.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Smart Login Module
::LoginRadiusSmartClient = LoginRadius::SmartLogin.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Social Login Module
::LoginRadiusSocialClient = LoginRadius::SocialLogin.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Token Management Module
::LoginRadiusTokenClient = LoginRadius::TokenManagement.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})

# Webhooks Module
::LoginRadiusWebhooksClient = LoginRadius::Webhooks.new({
  :site_name => "<Your LoginRadius AppName>",
  :api_key => "<Your ApiKey>",
  :api_secret => "<Your ApiSecret>",
  :customapidomain => "<Custom API domain (optional)>"
})
```

The API key and secret can be obtained from the LoginRadius dashboard. Details on retrieving your key and secret can be found [here](https://docs.loginradius.com/api/v2/dashboard/get-api-key-and-secret#retrieve-your-api-key-and-secret).
