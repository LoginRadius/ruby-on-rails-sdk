require_relative "../request_client"

module LoginRadius
  class MultiFactorAuthentication
    # Ruby wrapper for the LoginRadius Multi Factor Authentication API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2"
    
    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius MultiFactorAuthentication object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(required),
    # and custom_api_domain(optional)
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

      raise LoginRadius::Error.new("'site_name' is a required option for MultiFactorAuthentication class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for MultiFactorAuthentication class initialization.") \
        unless self.api_key != "" && self.api_key != nil
      raise LoginRadius::Error.new("'api_secret is a required option for MultiFactorAuthentication class initialization.") \
        unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - MFA Email Login:
    # Logs in by Email ID on a Multi-Factor Authentication enabled site.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-email-login
    #
    # @params email [String]               User's email address
    # @params password [String]            User's password
    # @params login_url [String]           Domain url which the user is logging in from
    # @params verification_url [String]    Url used for verification
    # @params email_template [String]      Email template name
    # @params sms_template_2fa [String]    SMS template name (for 2FA OTP)
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_email_login(email, password, login_url = "", verification_url = "", email_template = "", sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :loginurl => login_url,
        :verificationurl => verification_url,
        :emailtemplate => email_template,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "email" => email,
        "password" => password
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - MFA UserName Login:
    # Logs in by Username on a MFA enabled site.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-user-name-login
    #
    # @params username [String]            User's username
    # @params password [String]            User's password
    # @params login_url [String]           Domain url which the user is logging in from
    # @params verification_url [String]    Url used for verification
    # @params email_template [String]      Email template name
    # @params sms_template_2fa [String]    SMS template name (for 2FA OTP)
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_username_login(username, password, login_url = "", verification_url = "", email_template = "", sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :loginurl => login_url,
        :verificationurl => verification_url,
        :emailtemplate => email_template,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "username" => username,
        "password" => password
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - MFA Phone Login:
    # Logs in by Phone ID on a MFA enabled site.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-phone-login
    #
    # @params phone_id [String]            User's phone ID
    # @params password [String]            User's password
    # @params login_url [String]           Domain url which the user is logging in from
    # @params verification_url [String]    Url used for verification
    # @params email_template [String]      Email template name
    # @params sms_template_2fa [String]    SMS template name (for 2FA OTP)
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_phone_login(phone_id, password, login_url = "", verification_url = "", email_template = "", sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :loginurl => login_url,
        :verificationurl => verification_url,
        :emailtemplate => email_template,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phone" => phone_id,
        "password" => password
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - MFA Validate Access Token:
    # Configures MFA after login using access token. (For MFA optional)
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-access-token
    #
    # @params access_token [String]        User's access token
    # @params sms_template_2fa [String]    SMS template name
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_validate_access_token(access_token, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - MFA Backup Codes by Access Token:
    # Retrieves a set of backup codes using access token to allow user login on a site with MFA enabled
    # in the event that the user does not have a secondary factor available.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-backup-code-by-access-token
    #
    # @params access_token [String]        User's access token
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_backup_codes_by_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa/backupcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Reset Backup Codes by Access Token:
    # Resets the backup codes on a given account using access token. 
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-backup-code-by-access-token
    #
    # @params access_token [String]        User's access token
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_reset_backup_codes_by_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa/backupcode/reset",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - MFA Backup Codes by UID:
    # Retrieves a set of backup codes using UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-backup-code-by-uid
    #
    # @params uid [String]                 User's unified identifier
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_backup_codes_by_uid(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :uid => uid
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/2fa/backupcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - MFA Reset Backup Codes by UID:
    # Resets the backup codes on a given account using UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-backup-code-by-uid
    #
    # @params uid [String]                 User's unified identifier
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_reset_backup_codes_by_uid(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :uid => uid
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/2fa/backupcode/reset",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - MFA Validate Backup Code:
    # Validates the backup code provided by the user, returns an access token allowing user
    # to login.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-backup-code
    #
    # @params second_factor_authentication_token [String]  MFA identifier token generated after first authentication
    # @params backup_code [String]                         Backup code used for login
    #
    # @returns [LoginRadius::Response]                     LoginRadius response hash
    def mfa_validate_backup_code(second_factor_authentication_token, backup_code)
      params = {
        :apikey => self.api_key,
        :secondfactorauthenticationtoken => second_factor_authentication_token
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "backupcode" => backup_code
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa/verification/backupcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - MFA Validate OTP:
    # Validates the One Time Passcode received via SMS for use with MFA.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-otp
    #
    # @params second_factor_authentication_token [String]  MFA identifier token generated after first authentication
    # @params otp [String]                                 One Time Passcode, this argument is overloaded if data argument is used
    # @params data [Hash]                                  Hash containing OTP data, use this argument if you want to manually
    #                                                      send payload with additional keys eg. 'securityanswer', otherwise leave
    #                                                      blank or pass empty hash {}
    # @params sms_template_2fa [String]                    SMS template name
    #
    # @returns [LoginRadius::Response]                     LoginRadius response hash
    def mfa_validate_otp(second_factor_authentication_token, otp, data = {}, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :secondfactorauthenticationtoken => second_factor_authentication_token,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json"
      }

      if data == {}
        data = {
          "otp" => otp
        }
      end

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa/verification/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - MFA Validate Google Auth Code:
    # Validates google authenticator code for use with MFA.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-google-auth-code
    #
    # @params second_factor_authentication_token [String]  MFA identifier token generated after first authentication
    # @params google_auth_code [String]                    Code generated by Google Authenticator after scanning QR code
    # @params sms_template_2fa [String]                    SMS template name
    #
    # @returns [LoginRadius::Response]                     LoginRadius response hash
    def mfa_validate_google_auth_code(second_factor_authentication_token, google_auth_code, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :secondfactorauthenticationtoken => second_factor_authentication_token,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "googleauthenticatorcode" => google_auth_code
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa/verification/googleauthenticatorcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - MFA Update Phone Number:
    # Updates (if configured) the phone number used for MFA. API authenticates using the second factor
    # authentication token. Sends a verification OTP to provided phone number.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-update-phone-number
    #
    # @params second_factor_authentication_token [String]  MFA identifier token generated after first authentication
    # @params phone_no_2fa [Hash]                          Multi Factor phone number to be updated
    # @params sms_template_2fa [String]                    SMS template name
    #
    # @returns [LoginRadius::Response]                     LoginRadius response hash
    def mfa_update_phone_number(second_factor_authentication_token, phone_no_2fa, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :secondfactorauthenticationtoken => second_factor_authentication_token,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phoneno2fa" => phone_no_2fa
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/login/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - MFA Update Phone Number by Access Token:
    # Updates the MFA phone number by sending a verification OTP to the provided phone number. API authenticates
    # using user's login access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-update-phone-number-by-token
    #
    # @params access_token [String]         User's access token
    # @params phone_no_2fa [String]         Multi Factor phone number to be updated
    # @params sms_template_2fa [String]     SMS template name
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def mfa_update_phone_number_by_access_token(access_token, phone_no_2fa, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "phoneno2fa" => phone_no_2fa
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Update MFA by Access Token:
    # Enables Multi Factor Authentication by access token and Google Auth code upon user login.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/update-mfa-by-access-token
    #
    # @params access_token [String]                 User's access token
    # @params google_authenticator_code [String]    Code generated by Google Authenticator after scanning QR code
    # @params sms_template_2fa [String]             SMS template name
    #
    # @returns [LoginRadius::Response]              LoginRadius response hash
    def update_mfa_by_access_token(access_token, google_authenticator_code, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "googleauthenticatorcode" => google_authenticator_code
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa/verification/googleauthenticatorcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Update MFA Setting:
    # Enables Multi Factor Authentication by access token and OTP upon user login.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/update-mfa-setting
    #
    # @params access_token [String]         User's access token
    # @params otp [String]                  One Time Passcode, this argument is overloaded if data argument is used
    # @params data [Hash]                   Hash containing OTP data, use this argument if you want to manually
    #                                       send payload with additional keys eg. 'securityanswer', otherwise leave
    #                                       blank or pass an empty hash {}
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def update_mfa_setting(access_token, otp, data = {})
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      if data == {}
        data = {
          "otp" => otp
        }
      end

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa/verification/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - MFA Reset Google Authenticator by Access Token:
    # Resets the Google Authenticator configurations on a given account using user's access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-google-authenticator-by-token
    #
    # @params access_token [String]         User's access token
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def mfa_reset_google_authenticator_by_access_token(access_token) 
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "googleauthenticator" => true
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa/authenticator",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - MFA Reset SMS Authenticator by Access Token:
    # Resets the SMS Authenticator configurations on a given account using user's access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-sms-authenticator-by-token
    #
    # @params access_token [String]         User's access token
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def mfa_reset_sms_authenticator_by_access_token(access_token)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "otpauthenticator" => true
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/2fa/authenticator",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - MFA Reset Google Authenticator by UID:
    # Resets the Google Authenticator configurations on a given account using user's UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-google-authenticator-by-uid
    #
    # @params uid [String]                  Uid
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def mfa_reset_google_authenticator_by_uid(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :uid => uid
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "googleauthenticator" => true
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/2fa/authenticator",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - MFA Reset SMS Authenticator by UID:
    # Resets the SMS Authenticator configurations on a given account using user's UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-sms-authenticator-by-uid
    #
    # @params uid [String]                  Uid
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def mfa_reset_sms_authenticator_by_uid(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :uid => uid
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "otpauthenticator" => true
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/2fa/authenticator",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - Multi-Factor Re-Autentication workflow: 
    # Trigger the Multi-Factor re-Autentication workflow for the provided access_token 
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/re-authentication/mfa-re-authenticate
    #
    # @params access_token [String]        User's access token
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def mfa_re_authentication(access_token, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }
      
      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/reauth/2fa",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Validate MFA by Google Authenticator Code:
    # Re-authenticate via Multi-factor-authentication by passing the google authenticator code
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/re-authentication/validate-mfa-by-google-authenticator-code
    #
    # @params access_token [String]         User's access token
    # @param google_authenticator[String]   Code generated by Google Authenticator
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def validate_mfa_by_googleAuthCode(access_token, google_auth_code)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "googleauthenticatorcode" => google_auth_code
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/reauth/2fa/googleauthenticatorcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end


    # PUT - Validate MFA by Backup Code:  
    # re-authenticate by set of backup codes via access token
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/re-authentication/validate-mfa-by-backup-code
    #
    # @params access_token [String]         User's access token
    # @param backup_code[String]            Code generated by Google Authenticator
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def validate_mfa_by_backup_code(access_token, backup_code)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      data = {
        "backupcode" => backup_code
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/reauth/2fa/backupcode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Validate MFA by OTP:  
    # Re-authenticate via Multi-factor authentication by passing OTP received via SMS.
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/re-authentication/validate-mfa-by-otp
    #
    # @params access_token [String]         User's access token
    # @params otp [String]                                 One Time Passcode, this argument is overloaded if data argument is used
    # @params data [Hash]                                  Hash containing OTP data, use this argument if you want to manually
    #                                                      send payload with additional keys eg. 'securityanswer', otherwise leave
    #                                                      blank or pass empty hash {}
    # @params sms_template_2fa [String]                    SMS template name
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def validate_mfa_by_otp_code(access_token, otp, data = {}, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      if data == {}
        data = {
          "otp" => otp
        }
      end

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/reauth/2fa/otp",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Validate MFA by password:  
    # Verify event based multi factor authentication by Password
    # https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/re-authentication/validate-mfa-by-password
    #
    # @params access_token [String]                         User's access token
    # @params data [Hash]                                  Hash containing password data, use this argument if you want to manually
    #                                                      send payload with additional keys eg. 'securityanswer', otherwise leave
    #                                                      blank or pass empty hash {}
    # @params sms_template_2fa [String]                    SMS template name
    #
    # @returns [LoginRadius::Response]      LoginRadius response hash
    def validate_mfa_by_password(access_token, password, data = {}, sms_template_2fa = "")
      params = {
        :apikey => self.api_key,
        :smstemplate2fa => sms_template_2fa
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }
      if data == {}
        data = {
          "password" => password
        }
      end

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/account/reauth/password",
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
