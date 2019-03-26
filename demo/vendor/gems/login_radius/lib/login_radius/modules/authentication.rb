require_relative "../request_client"

module LoginRadius
  class Authentication
    # Ruby wrapper for the LoginRadius Authentication API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2/auth"

    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius Authentication object with an apikey
    # Takes in a hash containing site_name(required), api_key(required), api_secret(optional)
    # and custom_api_domain(optional)
    # api_secret is required for SOTT generation, which is needed for user registration
    def initialize(options = {
      :site_name => "",
      :api_key => "",
      :api_secret => "",
      :custom_api_domain => ""
    })
      self.site_name = options[:site_name]
      self.api_key = options[:api_key]
      self.api_secret = options[:api_secret]
      self.custom_api_domain = options[:custom_api_domain]

      raise LoginRadius::Error.new("'site_name' is a required option for Authentication class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for Authentication class initialization.") \
        unless self.api_key != "" && self.api_key != nil
    end

    # POST - Auth Add Email:
    # Adds additional emails to a user's account.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-add-email
    #
    # @params access_token [String]       User's access token
    # @params email [String]              Email to be added
    # @params type [String]               Email address classification (Primary/Secondary)
    # @params verification_url [String]   Url used for verification
    # @params email_template [String]     Email template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def add_email(access_token, email, type, verification_url = "", email_template = "")
      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :emailtemplate => email_template
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "email" => email,
        "type" => type
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Auth Forgot Password:
    # Sends a reset password url to a specified account.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-forgot-password
    #
    # @params reset_password_url [String]     Reset password url
    # @params email [String]                  Address for reset password link to be sent to
    # @params email_template [String]         Email template name
    #
    # @returns [LoginRadius::Response]        LoginRadius response hash
    def forgot_password(reset_password_url, email, email_template = "")
      params = {
        :apikey => self.api_key,
        :resetpasswordurl => reset_password_url,
        :emailtemplate => email_template
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "email" => email
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/password",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Auth User Registration by Email:
    # Creates a user in the database and sends a verification email to the user.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-user-registration-by-email
    #
    # @params data [Hash]                   Hash containing user registration data
    # @params verification_url [String]     Url used for verification
    # @params email_template [String]       Email template name
    # @params options [String]              PreventVerificationEmail setting
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def user_registration_by_email(data, verification_url = "", email_template = "", options = "")
      raise LoginRadius::Error.new("api_secret is required for SOTT generation for method user_registration_by_email") \
        unless self.api_secret != "" && self.api_secret != nil
      configuration_api = LoginRadius::Configuration.new({
        :site_name => self.site_name,
        :api_key => self.api_key,
        :api_secret => self.api_secret
      })

      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :emailtemplate => email_template,
        :options => options
      }
      headers = {
        "Content-Type" => "application/json",
        "X-LoginRadius-Sott" => configuration_api.local_generate_sott()
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/register",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Auth Login by Email:
    # Retrieves a copy of user data based on email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-login-by-email
    #
    # @params email [String]                   User's email address
    # @params password [String]                User's password
    # @params data [Hash]                      Hash containing user login data, use this argument if you want to manually
    #                                          send the payload with 'securityanswer' key, overloads email and password arguments,
    #                                          otherwise leave blank or pass empty hash {}
    # @params verification_url [String]        Url used for verification
    # @params login_url [String]               Url from where the user is logging in from
    # @params email_template [String]          Email template name
    # @params g_recaptcha_response [String]    Google Recaptcha response
    #
    # @returns [LoginRadius::Response]         LoginRadius response hash
    def login_by_email(email, password, data = {}, verification_url = "", login_url = "", email_template = "", g_recaptcha_response = "")
      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :loginurl => login_url,
        :emailtemplate => email_template,
        :"g-recaptcha-response" => g_recaptcha_response
      }
      headers = {
        "Content-Type" => "application/json"
      }

      if data == {}
        data = {
          "email" => email,
          "password" => password
        }
      end

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/login",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Auth Login by Username:
    # Retrieves a copy of user data based on username.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-login-by-username
    #
    # @params username [String]                User's username
    # @params password [String]                User's password
    # @params data [Hash]                      Hash containing user login data, use this argument if you want to manually
    #                                          send the payload with 'securityanswer' key, overloads username and password arguments,
    #                                          otherwise leave blank or pass empty hash {}
    # @params verification_url [String]        Url used for verification
    # @params login_url [String]               Url from where the user is logging in from
    # @params email_template [String]          Email template name
    # @params g_recaptcha_response [String]    Google Recaptcha response
    #
    # @returns [LoginRadius::Response]         LoginRadius response hash
    def login_by_username(username, password, data = {}, verification_url = "", login_url = "", email_template = "", g_recaptcha_response = "")
      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :loginurl => login_url,
        :emailtemplate => email_template,
        :"g-recaptcha-response" => g_recaptcha_response
      }
      headers = {
        "Content-Type" => "application/json"
      }

      if data == {}
        data = {
          "username" => username,
          "password" => password
        }
      end

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/login",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - Auth Check Email Availability:
    # Check if the specified email exists on your site.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-email-availability
    # 
    # @params email [String]             Email to check for availability
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def check_email_availability(email)
      params = {
        :apikey => self.api_key,
        :email => email
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
      end

    # GET - Auth Check Username Availability:
    # Check if the specified username exists on your site.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-username-availability
    # 
    # @params username [String]          Username to check for availability
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def check_username_availability(username)
      params = {
        :apikey => self.api_key,
        :username => username
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/username",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Read All Profiles by Token:
    # Retrieves a copy of user data based on access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-read-profiles-by-token
    #
    # @params access_token [String]      User's access token
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def read_profiles_by_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/account",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Privacy Policy Accept:
    # Updates the privacy policy status in a user's profile based on access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-privacy-policy-accept
    #
    # @params access_token [String]      User's access token
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def privacy_policy_accept(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/privacypolicy/accept",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Send Welcome Email:
    # Sends a welcome email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-send-welcome-email
    #
    # @params access_token [String]               User's access token
    # @params welcome_email_template [String]     Welcome email template name
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def send_welcome_email(access_token, welcome_email_template = "")
      params = {
        :apikey => self.api_key,
        :welcomeemailtemplate => welcome_email_template
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/sendwelcomeemail",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Social Identity:
    # Prevents RAAS profile of the second account from getting created (called before account linking API).
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-social-identity
    #
    # @params access_token [String]      User's access token
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def social_identity(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/socialidentity",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Validate Access Token:
    # Validates access token, returns an error if token is invalid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-validate-access-token
    # 
    # @params access_token [String]      User's access token
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def validate_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/validate",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Verify Email:
    # Verifies the email of a user.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-verify-email
    #
    # @params verification_token [String]       Verification token received in email
    # @params url [String]                      Domain url to be logged in database
    # @params welcome_email_template [String]   Welcome email template name
    #
    # @returns [LoginRadius::Response]          LoginRadius response hash
    def verify_email(verification_token, url = "", welcome_email_template = "")
      params = {
        :apikey => self.api_key,
        :verificationtoken => verification_token,
        :url => url,
        :welcomeemailtemplate => welcome_email_template
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Delete Account:
    # Delete an account based on delete token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-delete-account
    #
    # @params delete_token [String]       Delete token received in email
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def delete_account(delete_token)
      params = {
        :apikey => self.api_key,
        :deletetoken => delete_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/delete",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Invalidate Access Token:
    # Invalidates an active access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-invalidate-access-token
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def invalidate_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/invalidate",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Get Security Questions by Access Token:
    # Retrieves the list of security questions that have been configured for an account
    # by access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-access-token
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_security_questions_by_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/securityquestion/accesstoken",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Get Security Questions by Email:
    # Retrieves the list of security questions that have been configured for an account
    # by email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-email
    #
    # @params email [String]              User's email address
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_security_questions_by_email(email)
      params = {
        :apikey => self.api_key,
        :email => email
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/securityquestion/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Get Security Questions by Username:
    # Retrieves the list of security questions that have been configured for an account
    # by username.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-user-name
    #
    # @params username [String]           User's username
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_security_questions_by_username(username)
      params = {
        :apikey => self.api_key,
        :username => username
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/securityquestion/username",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Get Security Questions by Phone:
    # Retrieves the list of security questions that have been configured for an account
    # by phone ID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-phone
    #
    # @params phone [String]              User's phone ID
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_security_questions_by_phone(phone_id)
      params = {
        :apikey => self.api_key,
        :phone => phone_id
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/securityquestion/phone",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Auth Verify Email by OTP:
    # Verifies the email of a user when OTP Email verification flow is enabled.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-verify-email-by-otp
    # 
    # @params email [String]                     User's email address
    # @params otp [String]                       One Time Passcode
    # @params data [Hash]                        Hash containing verify data, use this argument if you want to
    #                                            manually send a payload with additional keys such as 'securityanswer',
    #                                            this will overload email and otp arguments, otherwise leave blank or pass in
    #                                            an empty hash {}
    # @params url [String]                       Domain url to be logged in database
    # @params welcome_email_template [String]    Welcome email template name
    #
    # @returns [LoginRadius::Response]           LoginRadius response hash
    def verify_email_by_otp(email, otp, data = {}, url = "", welcome_email_template = "")
      params = {
        :apikey => self.api_key,
        :url => url,
        :welcomeemailtemplate => welcome_email_template
      }
      headers = {
        "Content-Type" => "application/json"
      }

      if data == {}
        data = {
          "otp" => otp,
          "email" => email
        }
      end

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Change Password:
    # Changes an account's password based on previous password.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-change-password
    #
    # @params access_token [String]       User's access token
    # @params old_password [String]       User's current password
    # @params new_password [String]       User's new password
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def change_password(access_token, old_password, new_password)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "oldpassword" => old_password,
        "newpassword" => new_password
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/password/change",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Link Social Identities:
    # Links a social provider account with a specified account based on access token and social
    # provider's user access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-link-social-identities
    #
    # @params access_token [String]       User's access token
    # @params candidate_token [String]    Access token retrieved from the social account to be linked
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def link_social_identities(access_token, candidate_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "candidatetoken" => candidate_token
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/socialidentity",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Resend Email Verification:
    # Resends a verification email to the user.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-resend-email-verification
    # 
    # @params email [String]               User's email
    # @params verification_url [String]    Url used for verification
    # @params email_template [String]      Email template name
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def resend_email_verification(email, verification_url = "", email_template = "")
      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :emailtemplate => email_template
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "email" => email
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/register",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Reset Password by Reset Token:
    # Sets a new password for a specified account using a reset token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-reset-token
    #
    # @params reset_token [String]                      User's reset token recieved by email
    # @params new_password [String]                     New password
    # @params welcome_email_template [String]           Welcome email template name
    # @params reset_password_email_template [String]    Reset password email template name
    #
    # @returns [LoginRadius::Response]                  LoginRadius response hash
    def reset_password_by_reset_token(reset_token, new_password, welcome_email_template = "", reset_password_email_template = "")
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "resettoken" => reset_token,
        "password" => new_password,
        "welcomeemailtemplate" => welcome_email_template,
        "resetpasswordemailtemplate" => reset_password_email_template
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/password/reset",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Reset Password by OTP:
    # Sets a new password for a specified account using a One Time Passcode.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-otp
    #
    # @params otp [String]                              One Time Passcode received by email
    # @params email [String]                            User's email address
    # @params new_password [String]                     New password
    # @params welcome_email_template [String]           Welcome email template name
    # @params reset_password_email_template [String]    Reset password email template name
    #
    # @returns [LoginRadius::Response]                  LoginRadius response hash
    def reset_password_by_otp(otp, email, new_password, welcome_email_template = "", reset_password_email_template = "")
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "otp" => otp,
        "email" => email,
        "password" => new_password,
        "welcomeemailtemplate" => welcome_email_template,
        "resetpasswordemailtemplate" => reset_password_email_template
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/password/reset",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Reset Password by Security Answer and Email:
    # Sets a new password for a specified account using a security answer and email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-email
    #
    # @params data [Hash]                  Hash containing reset password data
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def reset_password_by_security_answer_and_email(data)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/password/securityanswer",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Reset Password by Security Answer and Phone:
    # Sets a new password for a specified account using a security answer and phone.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-phone
    #
    # @params data [Hash]                  Hash containing reset password data
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def reset_password_by_security_answer_and_phone(data)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/password/securityanswer",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Reset Password by Security Answer and UserName:
    # Sets a new password for a specified account using a security answer and username.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-username
    #
    # @params data [Hash]                  Hash containing reset password data
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def reset_password_by_security_answer_and_username(data)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/password/securityanswer",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Set or Change UserName:
    # Sets or changes a username using an access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-set-or-change-user-name
    # 
    # @params access_token [String]        User's access token
    # @params username [String]            New username
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def set_or_change_username(access_token, username)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "username" => username
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/username",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Auth Update Profile by Access Token:
    # Updates a user's profile using an access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-update-profile-by-token
    # 
    # @params access_token [String]        User's access token
    # @params data [Hash]                  Hash containing user update data
    # @params verification_url [String]    Url used for verification
    # @params email_template [String]      Email template name
    # @params sms_template [String]        SMS template name
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def update_profile_by_access_token(access_token, data, verification_url = "", email_template = "", sms_template = "")
      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :emailtemplate => email_template,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/account",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Update Security Questions by Access Token:
    # Updates security questions using an access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-update-security-question-by-access-token
    #
    # @params access_token [String]        User's access token
    # @params data [Hash]                  Hash containing update security question data
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def update_security_questions_by_access_token(access_token, data)
      params = {
        :apikey => self.api_key,
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/account",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Auth Delete Account with Email Confirmation:
    # Deletes a user account using its access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-delete-account-with-email-confirmation
    #
    # @params access_token [String]       User's access token
    # @params delete_url [String]         Domain url
    # @params email_template [String]     Email template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def delete_account_with_email_confirmation(access_token, delete_url = "", email_template = "")
      params = {
        :apikey => self.api_key,
        :deleteurl => delete_url,
        :emailtemplate => email_template
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/account",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # DELETE - Auth Remove Email:
    # Removes additional emails from a user's account.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-remove-email
    #
    # @params access_token [String]       User's access token
    # @params email [String]              Email to be removed
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def remove_email(access_token, email)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "email" => email
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Auth Unlink Social Identities:
    # Unlinks a social provider account with a specified account using its access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-unlink-social-identities
    #
    # @params access_token [String]       User's access token
    # @params provider_name [String]      Name of social provider
    # @params provider_id [String]        Unique identifier for the linked account
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def unlink_social_identities(access_token, provider_name, provider_id)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "provider" => provider_name,
        "providerid" => provider_id
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/socialidentity",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end
  end
end
