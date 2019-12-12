# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # SocialApi module
  class SocialApi
    include RequestClient

    attr_accessor :site_name, :api_key, :api_secret

    # Initializes a LoginRadius Account object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(required)
    def initialize
      @site_name = ENV['SITE_NAME']
      @api_key = ENV['API_KEY']
      @api_secret = ENV['API_SECRET']
      raise LoginRadius::Error.new, "'site_name' is a required option for Account class initialization." \
        unless @site_name != '' && @site_name != nil
      raise LoginRadius::Error.new, "'api_key' is a required option for Account class initialization." \
        unless @api_key != '' && @api_key != nil
      raise LoginRadius::Error.new, "'api_secret is a required option for Account class initialization." \
        unless @api_secret != '' && @api_secret != nil
    end

    # This API Is used to translate the Request Token returned during authentication into an Access Token that can be used with other API calls.
    #
    # @param token - Token generated from a successful oauth from social platform
    #
    # @return Response containing Definition of Complete Token data
    # 20.1
    def exchange_access_token(token)
      if isNullOrWhiteSpace(token)
        raise LoginRadius::Error.new, getValidationMessage('token')
      end

      query_parameters = {}
      query_parameters['secret'] = @api_secret
      query_parameters['token'] = token

      resource_path = 'api/v2/access_token'
      get_request(resource_path, query_parameters, nil)
    end

    # The Refresh Access Token API is used to refresh the provider access token after authentication. It will be valid for up to 60 days on LoginRadius depending on the provider. In order to use the access token in other APIs, always refresh the token using this API.<br><br><b>Supported Providers :</b> Facebook,Yahoo,Google,Twitter, Linkedin.<br><br> Contact LoginRadius support team to enable this API.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param expires_in - Allows you to specify a desired expiration time in minutes for the newly issued access token.
    #
    # @return Response containing Definition of Complete Token data
    # 20.2
    def refresh_access_token(access_token, expires_in)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['secret'] = @api_secret
      unless expires_in == false
        query_parameters['expiresIn'] = expires_in
      end

      resource_path = 'api/v2/access_token/refresh'
      get_request(resource_path, query_parameters, nil)
    end

    # This API validates access token, if valid then returns a response with its expiry otherwise error.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition of Complete Token data
    # 20.9
    def validate_access_token(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['key'] = @api_key
      query_parameters['secret'] = @api_secret

      resource_path = 'api/v2/access_token/validate'
      get_request(resource_path, query_parameters, nil)
    end

    # This api invalidates the active access token or expires an access token validity.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition for Complete Validation data
    # 20.10
    def in_validate_access_token(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['key'] = @api_key
      query_parameters['secret'] = @api_secret

      resource_path = 'api/v2/access_token/invalidate'
      get_request(resource_path, query_parameters, nil)
    end

    # This api is use to get all active session by Access Token.
    #
    # @param token - Token generated from a successful oauth from social platform
    #
    # @return Response containing Definition for Complete active sessions
    # 20.11.1
    def get_active_session(token)
      if isNullOrWhiteSpace(token)
        raise LoginRadius::Error.new, getValidationMessage('token')
      end

      query_parameters = {}
      query_parameters['key'] = @api_key
      query_parameters['secret'] = @api_secret
      query_parameters['token'] = token

      resource_path = 'api/v2/access_token/activesession'
      get_request(resource_path, query_parameters, nil)
    end

    # This api is used to get all active sessions by AccountID(UID).
    #
    # @param account_id - UID, the unified identifier for each user account
    #
    # @return Response containing Definition for Complete active sessions
    # 20.11.2
    def get_active_session_by_account_id(account_id)
      if isNullOrWhiteSpace(account_id)
        raise LoginRadius::Error.new, getValidationMessage('account_id')
      end

      query_parameters = {}
      query_parameters['accountId'] = account_id
      query_parameters['key'] = @api_key
      query_parameters['secret'] = @api_secret

      resource_path = 'api/v2/access_token/activesession'
      get_request(resource_path, query_parameters, nil)
    end

    # This api is used to get all active sessions by ProfileId.
    #
    # @param profile_id - Social Provider Id
    #
    # @return Response containing Definition for Complete active sessions
    # 20.11.3
    def get_active_session_by_profile_id(profile_id)
      if isNullOrWhiteSpace(profile_id)
        raise LoginRadius::Error.new, getValidationMessage('profile_id')
      end

      query_parameters = {}
      query_parameters['key'] = @api_key
      query_parameters['profileId'] = profile_id
      query_parameters['secret'] = @api_secret

      resource_path = 'api/v2/access_token/activesession'
      get_request(resource_path, query_parameters, nil)
    end

    # <b>Supported Providers:</b> Facebook, Google, Live, Vkontakte.<br><br> This API returns the photo albums associated with the passed in access tokens Social Profile.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Album Data
    # 22.2.1
    def get_albums(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/album'
      get_request(resource_path, query_parameters, nil)
    end

    # <b>Supported Providers:</b> Facebook, Google, Live, Vkontakte.<br><br> This API returns the photo albums associated with the passed in access tokens Social Profile.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response Model containing Albums with next cursor
    # 22.2.2
    def get_albums_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/album'
      get_request(resource_path, query_parameters, nil)
    end

    # The Audio API is used to get audio files data from the user's social account.<br><br><b>Supported Providers:</b> Live, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Audio Data
    # 24.2.1
    def get_audios(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/audio'
      get_request(resource_path, query_parameters, nil)
    end

    # The Audio API is used to get audio files data from the user's social account.<br><br><b>Supported Providers:</b> Live, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response Model containing Audio with next cursor
    # 24.2.2
    def get_audios_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/audio'
      get_request(resource_path, query_parameters, nil)
    end

    # The Check In API is used to get check Ins data from the user's social account.<br><br><b>Supported Providers:</b> Facebook, Foursquare, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of CheckIn Data
    # 25.2.1
    def get_check_ins(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/checkin'
      get_request(resource_path, query_parameters, nil)
    end

    # The Check In API is used to get check Ins data from the user's social account.<br><br><b>Supported Providers:</b> Facebook, Foursquare, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response Model containing Checkins with next cursor
    # 25.2.2
    def get_check_ins_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/checkin'
      get_request(resource_path, query_parameters, nil)
    end

    # The Contact API is used to get contacts/friends/connections data from the user's social account.This is one of the APIs that makes up the LoginRadius Friend Invite System. The data will normalized into LoginRadius' standard data format. This API requires setting permissions in your LoginRadius Dashboard. <br><br><b>Note:</b> Facebook restricts access to the list of friends that is returned. When using the Contacts API with Facebook you will only receive friends that have accepted some permissions with your app. <br><br><b>Supported Providers:</b> Facebook, Foursquare, Google, LinkedIn, Live, Twitter, Vkontakte, Yahoo
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response containing Definition of Contact Data with Cursor
    # 27.1
    def get_contacts(access_token, next_cursor = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      unless isNullOrWhiteSpace(next_cursor)
        query_parameters['nextCursor'] = next_cursor
      end

      resource_path = 'api/v2/contact'
      get_request(resource_path, query_parameters, nil)
    end

    # The Event API is used to get the event data from the user's social account.<br><br><b>Supported Providers:</b> Facebook, Live
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Events Data
    # 28.2.1
    def get_events(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/event'
      get_request(resource_path, query_parameters, nil)
    end

    # The Event API is used to get the event data from the user's social account.<br><br><b>Supported Providers:</b> Facebook, Live
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response Model containing Events with next cursor
    # 28.2.2
    def get_events_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/event'
      get_request(resource_path, query_parameters, nil)
    end

    # Get the following user list from the user's social account.<br><br><b>Supported Providers:</b> Twitter
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Contacts Data
    # 29.2.1
    def get_followings(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/following'
      get_request(resource_path, query_parameters, nil)
    end

    # Get the following user list from the user's social account.<br><br><b>Supported Providers:</b> Twitter
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response containing Definition of Contact Data with Cursor
    # 29.2.2
    def get_followings_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/following'
      get_request(resource_path, query_parameters, nil)
    end

    # The Group API is used to get group data from the user's social account.<br><br><b>Supported Providers:</b> Facebook, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Groups Data
    # 30.2.1
    def get_groups(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/group'
      get_request(resource_path, query_parameters, nil)
    end

    # The Group API is used to get group data from the user's social account.<br><br><b>Supported Providers:</b> Facebook, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response Model containing Groups with next cursor
    # 30.2.2
    def get_groups_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/group'
      get_request(resource_path, query_parameters, nil)
    end

    # The Like API is used to get likes data from the user's social account.<br><br><b>Supported Providers:</b> Facebook
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Likes Data
    # 31.2.1
    def get_likes(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/like'
      get_request(resource_path, query_parameters, nil)
    end

    # The Like API is used to get likes data from the user's social account.<br><br><b>Supported Providers:</b> Facebook
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response Model containing Likes with next cursor
    # 31.2.2
    def get_likes_with_cursor(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/like'
      get_request(resource_path, query_parameters, nil)
    end

    # The Mention API is used to get mentions data from the user's social account.<br><br><b>Supported Providers:</b> Twitter
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Status Data
    # 32.1
    def get_mentions(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/mention'
      get_request(resource_path, query_parameters, nil)
    end

    # Post Message API is used to post messages to the user's contacts.<br><br><b>Supported Providers:</b> Twitter, LinkedIn <br><br>The Message API is used to post messages to the user?s contacts. This is one of the APIs that makes up the LoginRadius Friend Invite System. After using the Contact API, you can send messages to the retrieved contacts. This API requires setting permissions in your LoginRadius Dashboard.<br><br>GET & POST Message API work the same way except the API method is different
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param message - Body of your message
    # @param subject - Subject of your message
    # @param to - Recipient's social provider's id
    #
    # @return Response containing Definition for Complete Validation data
    # 33.1
    def post_message(access_token, message, subject, to)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(message)
        raise LoginRadius::Error.new, getValidationMessage('message')
      end
      if isNullOrWhiteSpace(subject)
        raise LoginRadius::Error.new, getValidationMessage('subject')
      end
      if isNullOrWhiteSpace(to)
        raise LoginRadius::Error.new, getValidationMessage('to')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['message'] = message
      query_parameters['subject'] = subject
      query_parameters['to'] = to

      resource_path = 'api/v2/message'
      post_request(resource_path, query_parameters, nil)
    end

    # The Page API is used to get the page data from the user's social account.<br><br><b>Supported Providers:</b>  Facebook, LinkedIn
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param page_name - Name of the page you want to retrieve info from
    #
    # @return Response containing Definition of Complete page data
    # 34.1
    def get_page(access_token, page_name)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(page_name)
        raise LoginRadius::Error.new, getValidationMessage('page_name')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['pageName'] = page_name

      resource_path = 'api/v2/page'
      get_request(resource_path, query_parameters, nil)
    end

    # The Photo API is used to get photo data from the user's social account.<br><br><b>Supported Providers:</b>  Facebook, Foursquare, Google, Live, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param album_id - The id of the album you want to retrieve info from
    #
    # @return Response Containing List of Photos Data
    # 35.1
    def get_photos(access_token, album_id)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(album_id)
        raise LoginRadius::Error.new, getValidationMessage('album_id')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['albumId'] = album_id

      resource_path = 'api/v2/photo'
      get_request(resource_path, query_parameters, nil)
    end

    # The Post API is used to get post message data from the user's social account.<br><br><b>Supported Providers:</b>  Facebook
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response Containing List of Posts Data
    # 36.1
    def get_posts(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/post'
      get_request(resource_path, query_parameters, nil)
    end

    # The Status API is used to update the status on the user's wall.<br><br><b>Supported Providers:</b>  Facebook, Twitter, LinkedIn
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param caption - Message displayed below the description(Requires URL, Under 70 Characters).
    # @param description - Description of the displayed URL and Image(Requires URL)
    # @param imageurl - Image to be displayed in the share(Requires URL).
    # @param status - Main body of the Status update.
    # @param title - Title of Linked URL
    # @param url - URL to be included when clicking on the share.
    # @param shorturl - short url
    #
    # @return Response conatining Definition of Validation and Short URL data
    # 37.2
    def status_posting(access_token, caption, description, imageurl, status, title, url, shorturl = '0')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(caption)
        raise LoginRadius::Error.new, getValidationMessage('caption')
      end
      if isNullOrWhiteSpace(description)
        raise LoginRadius::Error.new, getValidationMessage('description')
      end
      if isNullOrWhiteSpace(imageurl)
        raise LoginRadius::Error.new, getValidationMessage('imageurl')
      end
      if isNullOrWhiteSpace(status)
        raise LoginRadius::Error.new, getValidationMessage('status')
      end
      if isNullOrWhiteSpace(title)
        raise LoginRadius::Error.new, getValidationMessage('title')
      end
      if isNullOrWhiteSpace(url)
        raise LoginRadius::Error.new, getValidationMessage('url')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['caption'] = caption
      query_parameters['description'] = description
      query_parameters['imageurl'] = imageurl
      query_parameters['status'] = status
      query_parameters['title'] = title
      query_parameters['url'] = url
      unless isNullOrWhiteSpace(shorturl)
        query_parameters['shorturl'] = shorturl
      end

      resource_path = 'api/v2/status'
      post_request(resource_path, query_parameters, nil)
    end

    # The Trackable status API works very similar to the Status API but it returns a Post id that you can use to track the stats(shares, likes, comments) for a specific share/post/status update. This API requires setting permissions in your LoginRadius Dashboard.<br><br> The Trackable Status API is used to update the status on the user's wall and return an Post ID value. It is commonly referred to as Permission based sharing or Push notifications.<br><br> POST Input Parameter Format: application/x-www-form-urlencoded
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param status_model - Model Class containing Definition of payload for Status API
    #
    # @return Response containing Definition for Complete status data
    # 37.6
    def trackable_status_posting(access_token, status_model)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if status_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('status_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token

      resource_path = 'api/v2/status/trackable'
      post_request(resource_path, query_parameters, status_model)
    end

    # The Trackable status API works very similar to the Status API but it returns a Post id that you can use to track the stats(shares, likes, comments) for a specific share/post/status update. This API requires setting permissions in your LoginRadius Dashboard.<br><br> The Trackable Status API is used to update the status on the user's wall and return an Post ID value. It is commonly referred to as Permission based sharing or Push notifications.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param caption - Message displayed below the description(Requires URL, Under 70 Characters).
    # @param description - Description of the displayed URL and Image(Requires URL)
    # @param imageurl - Image to be displayed in the share(Requires URL).
    # @param status - Main body of the Status update.
    # @param title - Title of Linked URL
    # @param url - URL to be included when clicking on the share.
    #
    # @return Response containing Definition for Complete status data
    # 37.7
    def get_trackable_status_stats(access_token, caption, description, imageurl, status, title, url)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(caption)
        raise LoginRadius::Error.new, getValidationMessage('caption')
      end
      if isNullOrWhiteSpace(description)
        raise LoginRadius::Error.new, getValidationMessage('description')
      end
      if isNullOrWhiteSpace(imageurl)
        raise LoginRadius::Error.new, getValidationMessage('imageurl')
      end
      if isNullOrWhiteSpace(status)
        raise LoginRadius::Error.new, getValidationMessage('status')
      end
      if isNullOrWhiteSpace(title)
        raise LoginRadius::Error.new, getValidationMessage('title')
      end
      if isNullOrWhiteSpace(url)
        raise LoginRadius::Error.new, getValidationMessage('url')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['caption'] = caption
      query_parameters['description'] = description
      query_parameters['imageurl'] = imageurl
      query_parameters['status'] = status
      query_parameters['title'] = title
      query_parameters['url'] = url

      resource_path = 'api/v2/status/trackable/js'
      get_request(resource_path, query_parameters, nil)
    end

    # The Trackable status API works very similar to the Status API but it returns a Post id that you can use to track the stats(shares, likes, comments) for a specific share/post/status update. This API requires setting permissions in your LoginRadius Dashboard.<br><br> This API is used to retrieve a tracked post based on the passed in post ID value. This API requires setting permissions in your LoginRadius Dashboard.<br><br> <b>Note:</b> To utilize this API you need to find the ID for the post you want to track, which might require using Trackable Status Posting API first.
    #
    # @param post_id - Post ID value
    #
    # @return Response containing Definition of Complete Status Update data
    # 37.8
    def trackable_status_fetching(post_id)
      if isNullOrWhiteSpace(post_id)
        raise LoginRadius::Error.new, getValidationMessage('post_id')
      end

      query_parameters = {}
      query_parameters['postId'] = post_id
      query_parameters['secret'] = @api_secret

      resource_path = 'api/v2/status/trackable'
      get_request(resource_path, query_parameters, nil)
    end

    # The User Profile API is used to get social profile data from the user's social account after authentication.<br><br><b>Supported Providers:</b>  All
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete UserProfile data
    # 38.1
    def get_social_user_profile(access_token, fields = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'api/v2/userprofile'
      get_request(resource_path, query_parameters, nil)
    end

    # The User Profile API is used to get the latest updated social profile data from the user's social account after authentication. The social profile will be retrieved via oAuth and OpenID protocols. The data is normalized into LoginRadius' standard data format. This API should be called using the access token retrieved from the refresh access token API.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete UserProfile data
    # 38.2
    def get_refreshed_social_user_profile(access_token, fields = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'api/v2/userprofile/refresh'
      get_request(resource_path, query_parameters, nil)
    end

    # The Video API is used to get video files data from the user's social account.<br><br><b>Supported Providers:</b>   Facebook, Google, Live, Vkontakte
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param next_cursor - Cursor value if not all contacts can be retrieved once.
    #
    # @return Response containing Definition of Video Data with Cursor
    # 39.2
    def get_videos(access_token, next_cursor)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(next_cursor)
        raise LoginRadius::Error.new, getValidationMessage('next_cursor')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['nextCursor'] = next_cursor

      resource_path = 'api/v2/video'
      get_request(resource_path, query_parameters, nil)
    end
  end
end
