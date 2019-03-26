require_relative "../request_client"

module LoginRadius
  class SocialLogin
    # Ruby wrapper for the LoginRadius Social Login API module.
    include RequestClient

    BASE_RESOURCE = "/api/v2"
    
    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius SocialLogin object with an apikey and secret
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

    raise LoginRadius::Error.new("'site_name' is a required option for SocialLogin class initialization.") \
      unless self.site_name != "" && self.site_name != nil
    raise LoginRadius::Error.new("'api_key' is a required option for SocialLogin class initialization.") \
      unless self.api_key != "" && self.api_key != nil
    raise LoginRadius::Error.new("'api_secret is a required option for SocialLogin class initialization.") \
      unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - Post Message API:
    # Posts messages to a user's contacts. This is part of the Friend Invite System.
    # Used after the Contact API, and requires setting of permissions in LR Dashboard.
    # (Twitter, LinkedIn)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/post-message-api
    #
    # @params access_token [String]       User's access token
    # @params to [String]                 Recipient's social provider ID
    # @params subject [String]            Subject of message
    # @params message [String]            Message body
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def post_message(access_token, to, subject, message)
      params = {
        :"access_token" => access_token,
        :to => to,
        :subject => subject,
        :message => message
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/message",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # POST - Status Posting POST:
    # Updates the status on a user's wall.
    # (Facebook, Twitter, LinkedIn)
    # https://docs.loginradius.com/api/v2/social-login/post-status-posting
    #
    # @params access_token [String]       User's access token
    # @params title [String]              Title of linked URL
    # @params url [String]                URL to be included when clicking on shared post
    # @params image_url [String]          Image to be displayed in shared post
    # @params status [String]             Status main body
    # @params caption [String]            Message to be displayed below description (under 70 characters)
    # @params description [String]        Description of displayed URL and image
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def status_posting_post(access_token, title, url, image_url, status, caption, description)
      params = {
        :"access_token" => access_token,
        :title => title,
        :url => url,
        :imageurl => image_url,
        :status => status,
        :caption => caption,
        :description => description
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/status",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Access Token:
    # Translates the request token returned during social provider authentication into an access token
    # that can be used with LR API calls.
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/access-token
    #
    # @params request_token [String]      Request token generated from authentication with social platform
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def translate_access_token(request_token)
      params = {
        :token => request_token,
        :secret => self.api_secret
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

    # GET - Validate Access Token:
    # Validates an access token, returns error if invalid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/validate-access-token
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def validate_access_token(access_token)
      params = {
        :key => self.api_key,
        :secret => self.api_secret,
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
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

    # GET - Invalidate Access Token:
    # Invalidates an active access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/invalidate-access-token
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def invalidate_access_token(access_token)
      params = {
        :key => self.api_key,
        :secret => self.api_secret,
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
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

    # GET - Album:
    # Retrieves the photo albums associated with an access token.
    # (Facebook, Google, Live, Vkontakte)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/album
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_albums(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/album",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Audio:
    # Retrieves the audio files associated with an access token.
    # (Live, Vkontakte)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/audio
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_audio(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/audio",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Check In:
    # Retrieves the check in data associated with an access token.
    # (Facebook, Foursquare, Vkontakte) 
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/check-in
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_checkins(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/checkin",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Company:
    # Retrieves a user's followed companies data associated with an access token.
    # (Facebook, LinkedIn)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/company
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_companies(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/company",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Contact:
    # Retrieves the contacts/friends/connections data associated with an access token. This is part of the
    # LR Friend Invite System, and requires permissions to be set in the LR Dashboard.
    # (Facebook, Foursquare, Google, LinkedIn, Live, Twitter, Vkontakte, Yahoo)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/contact
    #
    # @params access_token [String]       User's access token
    # @params next_cursor [String]        Cursor value if not all contacts can be retrieved at once
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_contacts(access_token, next_cursor = "")
      params = {
        :"access_token" => access_token,
        :nextcursor => next_cursor
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/contact",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Event:
    # Retrieves Event data associated with an access token.
    # (Facebook, Live)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/event
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_events(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/event",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Following:
    # Retrieves Following user list associated with an access token.
    # (Twitter)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/following
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_following(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/following",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Group:
    # Retrieves Group data associated with an access token.
    # (Facebook, Vkontakte)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/group
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_groups(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/group",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Like:
    # Retrieves Like data associated with an access token.
    # (Facebook)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/like
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_likes(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/like",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Mention:
    # Retrieves Mentions data associated with an access token.
    # (Twitter)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/mention
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_mentions(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/mention",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Get Message API:
    # Posts messages to a user's contacts. This is part of the Friend Invite System.
    # Used after the Contact API, and requires setting of permissions in LR Dashboard.
    # Identical to social_post_message, except that it uses GET.
    # (Twitter, LinkedIn)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/get-message-api
    #
    # @params access_token [String]       User's access token
    # @params to [String]                 Recipient's social provider ID
    # @params subject [String]            Subject of message
    # @params message [String]            Message body
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_message(access_token, to, subject, message)
      params = {
        :"access_token" => access_token,
        :to => to,
        :subject => subject,
        :message => message
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/message/js",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Page:
    # Retrieves page data associated with an access token.
    # (Facebook, LinkedIn)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/page
    #
    # @params access_token [String]       User's access token
    # @params page_name [String]          Name of page to retrieve from
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_page(access_token, page_name)
      params = {
        :"access_token" => access_token,
        :pagename => page_name
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/page",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Photo:
    # Retrieves photo data associated with an access token.
    # (Facebook, Foursquare, Google, Live, Vkontakte)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/photo
    #
    # @params access_token [String]       User's access token
    # @params album_id [String]           ID of album to retrieve from
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_photos(access_token, album_id)
      params = {
        :"access_token" => access_token,
        :albumid => album_id
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/photo",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Post:
    # Retrieves post message data associated with an access token.
    # (Facebook)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/post
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_posts(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/post",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Status Fetching:
    # Retrieves status messages associated with an access token.
    # (Facebook, Linkedin, Twitter, Vkontakte)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/status-fetching
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_statuses(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/status",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Status Posting:
    # Updates the status on a user (associated with an access token)'s wall.
    # Identical to status_posting_post.
    # (Facebook, Twitter, LinkedIn)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/status-posting
    #
    # @params access_token [String]       User's access token
    # @params title [String]              Title of linked URL
    # @params url [String]                URL to be included when clicking on shared post
    # @params image_url [String]          Image to be displayed in shared post
    # @params status [String]             Status main body
    # @params caption [String]            Message to be displayed below description (under 70 characters)
    # @params description [String]        Description of displayed URL and image
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def status_posting_get(access_token, title, url, image_url, status, caption, description)
      params = {
        :"access_token" => access_token,
        :title => title,
        :url => url,
        :imageurl => image_url,
        :status => status,
        :caption => caption,
        :description => description
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/status/js",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - User Profile:
    # Retrieves social profile data associated with an access token.
    # (All)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/user-profile
    #
    # @params access_token [String]       User's access token
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def user_profile(access_token)
      params = {
        :"access_token" => access_token
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/userprofile",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Video:
    # Retrieves video files data associated with an access token.
    # (Facebook, Google, Live, Vkontakte)
    # https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/video
    #
    # @params access_token [String]       User's access token
    # @params next_cursor [String]        Cursor value if not all values can be retrieved at once
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def get_videos(access_token, next_cursor = "")
      params = {
        :"access_token" => access_token,
        :nextcursor => next_cursor
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/video",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end
  end
end
