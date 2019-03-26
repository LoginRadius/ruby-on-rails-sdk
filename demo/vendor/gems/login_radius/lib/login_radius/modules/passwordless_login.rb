require_relative "../request_client"

module LoginRadius
  class PasswordlessLogin
    # Ruby wrapper for the LoginRadius Passwordless Login API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2/auth/login/passwordlesslogin"
    
    attr_accessor :site_name, :api_key, :custom_api_domain

    # Initializes a LoginRadius PasswordlessLogin object with an apikey
    # Takes in a hash containing site_name(required), api_key(required),
    # and custom_api_domain(optional)
    def initialize(options = {
      :site_name => "",
      :api_key => "",
      :custom_api_domain => ""
    })
      self.site_name = options[:site_name]
      self.api_key = options[:api_key]
      self.custom_api_domain = options[:custom_api_domain]

      raise LoginRadius::Error.new("'site_name' is a required option for PasswordlessLogin class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for PasswordlessLogin class initialization.") \
        unless self.api_key != "" && self.api_key != nil
    end

    # GET - Passwordless Login by Email:
    # Sends a Passwordless Login verification link to provided email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/passwordless-login-by-email
    #
    # @params email [String]                          User's email address
    # @params passwordless_login_template [String]    Passwordless Login template name
    # @params verification_url [String]               Url used for verification
    #
    # @returns [LoginRadius::Response]                LoginRadius response hash
    def passwordless_login_by_email(email, passwordless_login_template = "", verification_url = "")
      params = {
        :apikey => self.api_key,
        :email => email,
        :passwordlesslogintemplate => passwordless_login_template,
        :verificationurl => verification_url
      }
      
      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        {}
      )
    end

    # GET - Passwordless Login by UserName:
    # Sends a Passwordless Login verification link to provided username.
    # https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/passwordless-login-by-username
    #
    # @params username [String]                       User's username
    # @params passwordless_login_template [String]    Passwordless Login template name
    # @params verification_url [String]               Url used for verification
    #
    # @returns [LoginRadius::Response]                LoginRadius response hash
    def passwordless_login_by_username(username, passwordless_login_template = "", verification_url = "")
      params = {
        :apikey => self.api_key,
        :username => username,
        :passwordlesslogintemplate => passwordless_login_template,
        :verificationurl => verification_url
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/email",
          "api",
          self.custom_api_domain
        ),
        params,
        {}
      )
    end

    # GET - Passwordless Login Verification:
    # Verifies a Passwordless Login verification link.
    # https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/passwordless-login-verification
    #
    # @params verification_token [String]            Verification token received in email
    # @params welcome_email_template [String]        Welcome email template name
    #
    # @returns [LoginRadius::Response]               LoginRadius response hash
    def passwordless_login_verification(verification_token, welcome_email_template = "")
      params = {
        :apikey => self.api_key,
        :verificationtoken => verification_token,
        :welcomeemailtemplate => welcome_email_template
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/email/verify",
          "api",
          self.custom_api_domain
        ),
        params,
        {}
      )
    end
  end
end
