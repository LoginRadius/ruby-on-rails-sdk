Rails.application.routes.draw do
  get '',  to: redirect('index.html')
  post '',  to: redirect('index.html')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do

    get "get/profile/byemail", action: "accountProfileByEmail", controller: "login"
	
    get "apitest", action: "apitest", controller: "login"
    post "login/email", action: "email_login", controller: "login"
    post "forgotpassword", action: "forgot_password", controller: "login"
    get "login/passwordless", action: "passwordless_login", controller: "login"
    get "login/passwordless/auth", action: "passwordless_auth", controller: "login"
    put "login/resetpassword", action: "reset_password_by_reset_token", controller: "login"

    post "mfa/login/email", action: "mfa_email_login", controller: "mfa"
    get "mfa/validate", action: "mfa_validate_access_token", controller: "mfa"
    put "mfa/google/auth", action: "mfa_auth_google", controller: "mfa"
    put "mfa/google/enable", action: "mfa_enable_google_by_access_token", controller: "mfa"
    delete "mfa/google", action: "mfa_reset_google", controller: "mfa"

    post "register", action: "registration", controller: "registration"
    get "register/verify/email", action: "registration_verify_email", controller: "registration"

    get "profile", action: "read_profile_by_access_token", controller: "profile"
    put "profile/update", action: "account_update", controller: "profile"
    put "profile/changepassword", action: "change_password", controller: "profile"
    put "profile/setpassword", action: "set_password", controller: "profile"

    post "roles", action: "create_role", controller: "roles"
    get "roles", action: "roles_list", controller: "roles"
    get "roles/get", action: "roles_by_uid", controller: "roles"
    put "roles", action: "assign_role_by_uid", controller: "roles"
    delete "roles", action: "delete_role", controller: "roles"

    post "customobj", action: "create_custom_object_by_access_token", controller: "customobject"
    get "customobj", action: "get_custom_object_by_access_token", controller: "customobject"
    put "customobj", action: "update_custom_object_by_access_token", controller: "customobject"
    delete "customobj", action: "delete_custom_object_by_access_token", controller: "customobject"
  end
end
