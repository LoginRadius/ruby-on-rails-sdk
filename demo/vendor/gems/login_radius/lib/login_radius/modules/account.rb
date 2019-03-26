require_relative "../request_client"

module LoginRadius
  class Account
    # Ruby wrapper for the LoginRadius Account API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2/manage/account"

    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius Account object with an apikey and secret
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

      raise LoginRadius::Error.new("'site_name' is a required option for Account class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for Account class initialization.") \
        unless self.api_key != "" && self.api_key != nil
      raise LoginRadius::Error.new("'api_secret is a required option for Account class initialization.") \
        unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - Account Create:
    # Creates an account in LoginRadius Cloud Storage, bypassing the normal
    # email verification process.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-create
    #
    # @params data [Hash]      Hash containing account information
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_create(data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Email Verification Token:
    # Retrieves an Email Verification token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/get-email-verification-token
    #
    # @params email [String]              User's email address
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def email_verification_token(email)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "email" => email
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/verify/token",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Forgot Password Token:
    # Retrieves a Forgot Password token. Default email workflow.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/get-forgot-password-token
    #
    # @params email [String]              User's email address
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def forgot_password_token(email)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "email" => email
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/forgot/token",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Forgot Password Token:
    # Retrieves a Forgot Password token. For the username workflow.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/get-forgot-password-token
    #
    # @params username [String]           User's username
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def forgot_password_token_username(username)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "username" => username
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/forgot/token",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end


    # GET - Account Identities by Email:
    # Retrieves all identities associated with a specified email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-identities-by-email
    #
    # @params email [String]    User's email address
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_identities_by_email(email)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :email => email
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/identities",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Access Token Based on UID or User Impersonation:
    # Retrieves a LoginRadius access token based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-impersonation-api
    #
    # @params uid [String]    User's unified identifier
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def user_impersonation(uid)
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
          BASE_RESOURCE + "/access_token",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Account Password:
    # Retrieves the hashed password of an account based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-password
    #
    # @params uid [String]    User's unified identifier
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_password(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid + "/password",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Account Profiles by Email:
    # Retrieves profile data based on email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-email
    #
    # @params email [String]    User's email address
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_profiles_by_email(email)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :email => email
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }
      
      return get_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Account Profiles by UserName:
    # Retrieves profile data based on username.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-user-name
    #
    # @params username [String]    User's username
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_profiles_by_username(username)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :username => username
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }
      
      return get_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Account Profiles by Phone ID:
    # Retrieves profile data based on phone ID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-phone-id
    #
    # @params phone_id [String]    User's phone ID
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_profiles_by_phoneid(phone_id)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :phone => phone_id
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }
      
      return get_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Account Profiles by UID:
    # Retrieves profile data based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-uid
    #
    # @params uid [String]    User's unified identifier
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_profiles_by_uid(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }
      
      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Account Set Password:
    # Sets the password of an account.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-set-password
    #
    # @params uid [String]                User's unified identifier
    # @params new_password [String]       New password
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_set_password(uid, new_password)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "password" => new_password
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid + "/password",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Account Update:
    # Updates the information of an existing account based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-update
    #
    # @params uid [String]              User's unified identifier
    # @params data [Hash]               Hash containing data to be updated on user's profile
    # @params nullsupport [Boolean]     Boolean to allow profile to be updated with null values
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_update(uid, data, nullsupport = false)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :nullsupport => nullsupport
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Account Update Security Question Configuration:
    # Updates the security questions configuration of an existing account based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-update-security-question
    #
    # @params uid [String]       User's unified identifier
    # @params data [Hash]        Hash containing security question update data 
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_update_security_question_configuration(uid, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Account Invalidate Verification Status:
    # Invalidates the Email Verification status of an account.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-invalidate-verification-email
    #
    # @params uid [String]                User's unified identifier
    # @params verification_url [String]   Url used for verification
    # @params email_template [String]     Email template name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_invalidate_verification_status(uid, verification_url = "", email_template = "")
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :verificationurl => verification_url,
        :emailtemplate => email_template
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid + "/invalidateemail",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # DELETE - Account Email Delete:
    # Removes an email on an existing account based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-email-delete
    # 
    # @params uid [String]                User's unified identifier
    # @params email [String]              Email to be removed
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_email_delete(uid, email)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "email" => email
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Account Delete:
    # Removes an existing user account based on UID.
    # https://docs.loginradius.com/api/v2/customer-identity-api/account/account-delete
    #
    # @params uid [String]    User's unified identifier
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def account_delete(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/" + uid,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end
  end
end
