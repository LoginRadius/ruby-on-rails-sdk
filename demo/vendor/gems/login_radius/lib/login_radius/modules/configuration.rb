require "openssl"
require "base64"
require "digest"

require_relative "../request_client"

module LoginRadius
  class Configuration
    # Ruby wrapper for the LoginRadius Configuration API module.
    include RequestClient

    INIT_VECTOR = "tu89geji340t89u2"
    KEY_SIZE = 256

    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius Configuration object with an apikey and secret
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

      raise LoginRadius::Error.new("'site_name' is a required option for Configuration class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for Configuration class initialization.") \
        unless self.api_key != "" && self.api_key != nil
      raise LoginRadius::Error.new("'api_secret is a required option for Configuration class initialization.") \
        unless self.api_secret != "" && self.api_secret != nil
    end

    # GET - Get Configurations:
    # Gets set configurations from the LoginRadius Dashboard for a particular site from apikey.
    # https://docs.loginradius.com/api/v2/customer-identity-api/configuration/get-configurations
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_configurations()
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          "/ciam/appinfo",
          "config",
          self.custom_api_domain
        ),
        params,
        {}
      )
    end

    # GET - Get Server Time:
    # Queries for basic server information. Time difference is used to generate values for
    # SOTT generation.
    # https://docs.loginradius.com/api/v2/customer-identity-api/configuration/get-server-time
    #
    # @params time_difference [String]    Time difference
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_server_time(time_difference = 10)
      params = {
        :apikey => self.api_key,
        :timedifference => time_difference
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          "/identity/v2/serverinfo",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Get Active Session Details:
    # Retrieves all active sessions by an access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/get-active-session-details
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_active_session_details(access_token)
      params = {
        :key => self.api_key,
        :secret => self.api_secret,
        :token => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          "/api/v2/access_token/activesession",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Generate SOTT:
    # Generates a Secured One Time Token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/session/generate-sott-token
    #
    # @params time_difference [Integer]   Time difference
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def generate_sott(time_difference = 10)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :timedifference => time_difference
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          "/identity/v2/manage/account/sott",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # Local - Generate SOTT:
    # Generates a Secured One Time Token locally.
    #
    # @params validity_length [Integer]    Length of time the SOTT is valid for in minutes
    #
    # @returns sott [String]               LoginRadius Secured One Time Token
    def local_generate_sott(validity_length = 10)
      start_time = Time.now.getutc().strftime("%Y/%m/%d %H:%M:%S")
      end_time = (Time.now.getutc() + (validity_length*60)).strftime("%Y/%m/%d %H:%M:%S")

      plain_text = start_time + "#" + self.api_key + "#" + end_time
      iter = 10000
      salt = "\x00\x00\x00\x00\x00\x00\x00\x00"
      key_len = KEY_SIZE / 8
      cipher_key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(self.api_secret, salt, iter, key_len)

      cipher = OpenSSL::Cipher.new("aes-" + KEY_SIZE.to_s + "-cbc")
      cipher.encrypt
      cipher.key = cipher_key
      cipher.iv = INIT_VECTOR

      encrypted = cipher.update(plain_text) + cipher.final
      encrypted_b64 = Base64.strict_encode64(encrypted)
      
      hash = Digest::MD5.hexdigest(encrypted_b64)
      sott = encrypted_b64 + "*" + hash

      return sott
    end
  end
end
