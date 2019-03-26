require_relative "../request_client"

module LoginRadius
  class OneTouchLogin
    # Ruby wrapper for the LoginRadius One Touch Login API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2/auth"
    
    attr_accessor :site_name, :api_key, :custom_api_domain

    # Initializes a LoginRadius OneTouchLogin object with an apikey
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

      raise LoginRadius::Error.new("'site_name' is a required option for OneTouchLogin class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for OneTouchLogin class initialization.") \
        unless self.api_key != "" && self.api_key != nil
    end

    # POST - One Touch Login by Email:
    # Sends a link to a specified email for frictionless login.
    # https://docs.loginradius.com/api/v2/customer-identity-api/one-touch-login/one-touch-login-by-email-captcha
    #
    # @params data [Hash]                                 Hash containing One Touch Login email data
    # @params redirect_url [String]                       Url to redirect the user to after successful authentication
    # @params one_touch_login_email_template [String]     One Touch Login email template name
    # @params welcome_email_template [String]             Welcome email template name
    #
    # @returns [LoginRadius::Response]                    LoginRadius response hash
    def one_touch_login_by_email(data, redirect_url = "", one_touch_login_email_template = "", welcome_email_template = "")
      params = {
        :apikey => self.api_key,
        :redirecturl => redirect_url,
        :onetouchloginemailtemplate => one_touch_login_email_template,
        :welcomeemailtemplate => welcome_email_template
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/onetouchlogin/email",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - One Touch Login by Phone:
    # Sends a One Time Passcode to a given phone number for a frictionless login.
    # https://docs.loginradius.com/api/v2/customer-identity-api/one-touch-login/one-touch-login-by-phone-captcha
    #
    # @params data [Hash]                   Hash containing One Touch Login phone data
    # @params sms_template [String]         SMS template name
    #
    # @returns [LoginRadius::Response]                    LoginRadius response hash
    def one_touch_login_by_phone(data, sms_template = "")
      params = {
        :apikey => self.api_key,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/onetouchlogin/phone",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - One Touch OTP Verification by Email:
    # Verifies the provided token for One Touch Login by email.
    # https://docs.loginradius.com/api/v2/customer-identity-api/one-touch-login/one-touch-email-verification
    #
    # @params verification_token [String]         Verification token sent by email
    # @params welcome_email_template [String]     Welcome email template name
    #
    # @returns [LoginRadius::Response]            LoginRadius response hash
    def one_touch_email_verification(verification_token, welcome_email_template = "")
      params = {
        :apikey => self.api_key,
        :verificationtoken => verification_token,
        :welcomeemailtemplate => welcome_email_template
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/email/smartlogin",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - One Touch OTP Verification:
    # Verifies the One Time Passcode for One Touch Login.
    # https://docs.loginradius.com/api/v2/customer-identity-api/one-touch-login/one-touch-otp-verification
    #
    # @params otp [String]                 One Time Passcode
    # @params phone [String]               User's phone ID
    # @params sms_template [String]        SMS template name
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def one_touch_otp_verification(otp, phone, sms_template = "")
      params = {
        :apikey => self.api_key,
        :otp => otp,
        :smstemplate => sms_template
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "phone" => phone
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/onetouchlogin/phone/verify",
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
