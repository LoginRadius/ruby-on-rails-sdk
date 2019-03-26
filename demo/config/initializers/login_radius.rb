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
