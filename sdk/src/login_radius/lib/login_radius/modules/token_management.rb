require_relative "../request_client"

module LoginRadius
  class TokenManagement
    # Ruby wrapper for the LoginRadius Token Management API Module.
    include RequestClient

    BASE_RESOURCE = "/api/v2"
    
    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius TokenManagement object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(required)
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

    raise LoginRadius::Error.new("'site_name' is a required option for TokenManagement class initialization.") \
      unless self.site_name != "" && self.site_name != nil
    raise LoginRadius::Error.new("'api_key' is a required option for TokenManagement class initialization.") \
      unless self.api_key != "" && self.api_key != nil
    raise LoginRadius::Error.new("'api_secret is a required option for TokenManagement class initialization.") \
      unless self.api_secret != "" && self.api_secret != nil
    end

    # GET - Access Token via Facebook Token:
    # Retrieves a LoginRadius access token by sending Facebook's access token.
    # https://docs.loginradius.com/api/v2/advanced-social-api/access-token-via-facebook-token
    #
    # @param fb_access_token [String]
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def access_token_via_facebook_token(fb_access_token)
      params = {
        :key => self.api_key,
        :"fb_access_token" => fb_access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/facebook",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Access Token via Twitter Token:
    # Retrieves a LoginRadius access token by sending Twitter's access token and token secret.
    # https://docs.loginradius.com/api/v2/advanced-social-api/access-token-via-twitter-token
    #
    # @params tw_access_token [String]
    # @params tw_token_secret [String]
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def access_token_via_twitter_token(tw_access_token, tw_token_secret)
      params = {
        :key => self.api_key,
        :"tw_access_token" => tw_access_token,
        :"tw_token_secret" => tw_token_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/twitter",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Access Token via Vkontakte Token:
    # Retrieves a LoginRadius access token by sending Vkontakte's access token.
    # https://docs.loginradius.com/api/v2/advanced-social-api/access-token-via-vk-token
    #
    # @params vk_access_token [String]
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def access_token_via_vkontakte_token(vk_access_token)
      params = {
        :key => self.api_key,
        :"vk_access_token" => vk_access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/vkontakte",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Access Token via Google JWT:
    # Retrieves a LoginRadius access token by sending Google's JWT id_token. This API will
    # create a new 'googlejwt' provider profile for the customer using fields obtained.
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/native-social-login-api/access-token-via-googlejwt
    #
    # @params id_token [String]            Google JWT id_token
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def access_token_via_google_jwt(id_token)
      params = {
        :key => self.api_key,
        :"id_token" => id_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/googlejwt",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Refresh User Profile:
    # Retrieves the latest updated social profile data after authentication.
    # https://docs.loginradius.com/api/v2/customer-identity-api/refresh-token/refresh-user-profile
    #
    # @params access_token [String]        User's access token
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def refresh_user_profile(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/userprofile/refresh",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Refresh Access Token:
    # Refreshes the LoginRadius access token after authentication. Also refreshes the
    # provider access token if available (Facebook, Yahoo, Google).
    # https://docs.loginradius.com/api/v2/customer-identity-api/refresh-token/refresh-token
    #
    # @params access_token [String]        User's access token
    # @params expires_in [String]          Desired expiration time in minutes
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def refresh_access_token(access_token, expires_in = "")
      params = {
        :"access_token" => access_token,
        :secret => self.api_secret,
        :expiresIn => expires_in
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/access_token/refresh",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end
  end
end
