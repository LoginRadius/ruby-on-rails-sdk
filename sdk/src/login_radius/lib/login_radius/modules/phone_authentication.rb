require_relative "../request_client"

module LoginRadius
  class PhoneAuthentication
    # Ruby wrapper for the LoginRadius Phone Authentication API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2"
    
    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius PhoneAuthentication object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(optional),
    # and custom_api_domain(optional)
    # api_secret is needed for SOTT generation (user registration) and reset phone id by Uid
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

      raise LoginRadius::Error.new("'site_name' is a required option for PhoneAuthentication class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for PhoneAuthentication class initialization.") \
        unless self.api_key != "" && self.api_key != nil
    end

    # POST - Phone Login:
    # Retrieves a copy of user data based on Phone ID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-login
    #
    # @params phone_id [String]              User's phone ID
    # @params password [String]              User's password
    # @params data [Hash]                    Hash containing phone login data, use this argument if you want
    #                                        to manually send a payload containing 'securityanswer' key, overrides 
    #                                        arguments phone_id and password, otherwise leave blank or pass an 
    #                                        empty hash {}
    # @params login_url [String]             Domain url which the user is logging in from
    # @params sms_template [String]          SMS template name
    # @params g-recaptcha-response [String]  Google Recaptcha response
    #
    # @returns [LoginRadius::Response]       LoginRadius response hash
    def phone_login(phone_id, password, data = {}, login_url = "", sms_template = "", g_recaptcha_response = "")
      params = {
        :apikey => self.api_key,
        :loginurl => login_url,
        :smstemplate => sms_template,
        :"g-recaptcha-response" => g_recaptcha_response
      }
      headers = {
        "Content-Type" => "application/json"
      }

      if data == {}
        data = {
          "phone" => phone_id,
          "password" => password
        }
      end

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Phone Forgot Password by OTP:
    # Sends OTP to reset the account password.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-forgot-password-by-otp
    #
    # @params phone_id [String]           User's phone ID
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_forgot_password_by_otp(phone_id, sms_template = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phone" => phone_id
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/password/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Phone Resend Verification OTP:
    # Resends a verification OTP to verify a user's phone number. User will receive a verification
    # code that they will need to input.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-resend-otp
    #
    # @params phone_id [String]           User's phone ID
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_resend_verification_otp(phone_id, sms_template = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phone" => phone_id
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Phone Resend Verification OTP by Access Token:
    # Resends a verification OTP to verify a user's phone number in cases where an active token
    # already exists.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-resend-otp-by-token
    #
    # @params access_token [String]       User's access token
    # @params phone_id [String]           User's phone ID
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_resend_verification_otp_by_access_token(access_token, phone_id, sms_template = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "phone" => phone_id
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Phone User Registration by SMS:
    # Registers a new user into Cloud Storage and triggers the phone verification process.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-user-registration-by-sms
    #
    # @params data [Hash]                 Hash containing user registration data
    # @params verification_url [String]   Url used for verification
    # @params sms_template [String]       SMS template name
    # @params options [String]            PreventVerificationEmail
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_user_registration_by_sms(data, verification_url = "", sms_template = "", options = "")
      raise LoginRadius::Error.new("api_secret is required for SOTT generation for method phone_user_registration_by_sms") \
        unless self.api_secret != "" && self.api_secret != nil
      configuration_api = LoginRadius::Configuration.new({
        :site_name => self.site_name,
        :api_key => self.api_key,
        :api_secret => self.api_secret
      })

      params = {
        :apikey => self.api_key,
        :verificationurl => verification_url,
        :smstemplate => sms_template,
        :options => options
      }
      headers = {
        "Content-Type" => "application/json",
        "X-LoginRadius-Sott" => configuration_api.local_generate_sott()
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/register",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - Phone Number Availability:
    # Checks if the specified phone number already exists on your site.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-number-availability
    #
    # @params phone_id [String]           User's phone ID
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_number_availability(phone_id)
      params = {
        :apikey => self.api_key,
        :phone => phone_id
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Phone Send One Time Passcode:
    # Sends a One Time Passcode by verified phone ID.
    # This API is listed under the Passwordless Login section.
    # https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/phone-send-otp
    #
    # @params phone_id [String]           User's phone ID
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_send_otp(phone_id, sms_template = "")
      params = {
        :apikey => self.api_key,
        :phone => phone_id,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/passwordlesslogin/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Phone Login Using One Time Passcode:
    # Verifies a login by One Time Passcode.
    # This API is listed under the Passwordless Login section.
    # https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/phone-login-using-otp
    #
    # @params phone_id [String]           User's phone ID
    # @params otp [String]                One Time Passcode
    # @params data [Hash]                 Hash containing phone login data, use this argument if you need to manually
    #                                     send a payload with additional keys eg. 'securityanswer', overloads phone_id and otp
    #                                     arguments, otherwise leave blank or pass an empty hash {}
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_login_using_otp(phone_id, otp, data = {}, sms_template = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json"
      }

      if data == {}
        data = {
          "phone" => phone_id,
          "otp" => otp
        }
      end

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/passwordlesslogin/otp/verify",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Phone Number Update:
    # Updates a user's login phone number.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-number-update
    #
    # @params access_token [String]       User's access token
    # @params new_phone_id [String]       User's new phone ID
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_number_update(access_token, new_phone_id, sms_template = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "phone" => new_phone_id
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Phone Reset Password by OTP:
    # Resets a user's password using OTP.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-reset-password-by-otp
    #
    # @params phone_id [String]                        User's phone ID
    # @params otp [String]                             One Time Passcode
    # @params new_password [String]                    User's new password
    # @params sms_template [String]                    SMS template name
    # @params reset_password_email_template [String]   Reset password email template name
    #
    # @returns [LoginRadius::Response]                 LoginRadius response hash
    def phone_reset_password_by_otp(phone_id, otp, new_password, sms_template = "", reset_password_email_template = "")
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phone" => phone_id,
        "otp" => otp,
        "password" => new_password,
        "smstemplate" => sms_template,
        "resetpasswordemailtemplate" => reset_password_email_template
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/password/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Phone Verification by OTP:
    # Validates the verification code sent to verify a user's phone number.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-verify-otp
    #
    # @params otp [String]                One Time Passcode
    # @params phone_id [String]           User's phone ID to verify
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_verification_by_otp(otp, phone_id, sms_template = "")
      params = {
        :apikey => self.api_key,
        :otp => otp,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phone" => phone_id
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Phone Verification OTP by Access Token:
    # Consumes the verification code sent to verify a user's phone number. For use in front-end where
    # user has already logged in by passing user's access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-verify-otp-by-token
    #
    # @params access_token [String]       User's access token
    # @params otp [String]                One Time Passcode
    # @params sms_template [String]       SMS template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def phone_verification_otp_by_access_token(access_token, otp, sms_template = "")
      params = {
        :apikey => self.api_key,
        :otp => otp,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )      
    end

    # PUT - Reset Phone ID Verification:
    # Resets phone number verification of a user's account.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/reset-phone-id-verification
    #
    # @params uid [String]               User's unified identifier
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def reset_phone_id_verification(uid)
      raise LoginRadius::Error.new("api_secret is required for method reset_phone_id_verification") \
        unless self.api_secret != "" && self.api_secret != nil
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/" + uid + "/invalidatephone",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # DELETE - Remove Phone ID by Access Token:
    # Deletes the Phone ID on a user's account using access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/remove-phone-id-by-access-token
    #
    # @params access_token [String]      User's access token
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def remove_phone_id_by_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/phone",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end
  end
end
