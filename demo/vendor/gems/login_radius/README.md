## Installation

Install the SDK by adding LoginRadius to your application's `Gemfile`.

```
gem 'login_radius', '~> 11.4.0'
```

Then, run `$ bundle`. A copy of the SDK can also be found on our [Github](https://github.com/LoginRadius/ruby-on-rails-gem/tree/master).

## Quickstart Guide

1)Before using any of the functions available in the library, its corresponding module must first define the global constant in `config/application.yml`:

```
SITE_NAME: "<site name>"
API_KEY: "<api-key>"
API_SECRET: "<api-secret>"
CUSTOM_API_DOMAIN: "<custom-domain-url-if-any>"
API_REQUEST_SIGNING: "false"
```

2)After define the configuration key details, its corresponding module must first be instantiated:

Create `login_radius.rb` in `/config/initializers`:



```
require 'login_radius'

::AccountApi = LoginRadius::AccountApi.new
::RoleApi = LoginRadius::RoleApi.new
::SottApi = LoginRadius::SottApi.new

::ConfigurationApi = LoginRadius::ConfigurationApi.new
::ConsentManagementApi = LoginRadius::ConsentManagementApi.new
::CustomObjectApi = LoginRadius::CustomObjectApi.new
::CustomRegistrationDataApi = LoginRadius::CustomRegistrationDataApi.new
::MultiFactorAuthenticationApi = LoginRadius::MultiFactorAuthenticationApi.new
::ReAuthenticationApi = LoginRadius::ReAuthenticationApi.new
::WebHookApi = LoginRadius::WebHookApi.new

::AuthenticationApi = LoginRadius::AuthenticationApi.new
::OneTouchLoginApi = LoginRadius::OneTouchLoginApi.new
::PasswordLessLoginApi = LoginRadius::PasswordLessLoginApi.new
::PhoneAuthenticationApi = LoginRadius::PhoneAuthenticationApi.new
::PINAuthenticationApi = LoginRadius::PINAuthenticationApi.new
::RiskBasedAuthenticationApi = LoginRadius::RiskBasedAuthenticationApi.new
::SmartLoginApi = LoginRadius::SmartLoginApi.new

::NativeSocialApi = LoginRadius::NativeSocialApi.new
::SocialApi = LoginRadius::SocialApi.new
```

Please note that you only have to initiate modules you need.

The API key and secret can be obtained from the LoginRadius Admin Console. Details on retrieving your key and secret can be found [here](loginradius.com/docs/api/v2/admin-console/platform-security/api-key-and-secret/).
