require_relative "login_radius/version"
require_relative "login_radius/error"
require_relative "login_radius/response"
require_relative "login_radius/modules/account"
require_relative "login_radius/modules/authentication"
require_relative "login_radius/modules/configuration"
require_relative "login_radius/modules/custom_object_management"
require_relative "login_radius/modules/custom_registration_data"
require_relative "login_radius/modules/multi_factor_authentication"
require_relative "login_radius/modules/one_touch_login"
require_relative "login_radius/modules/passwordless_login"
require_relative "login_radius/modules/phone_authentication"
require_relative "login_radius/modules/roles_management"
require_relative "login_radius/modules/smart_login"
require_relative "login_radius/modules/social_login"
require_relative "login_radius/modules/token_management"
require_relative "login_radius/modules/webhooks"

require "json"

module LoginRadius
  # LoginRadius parent module
end
