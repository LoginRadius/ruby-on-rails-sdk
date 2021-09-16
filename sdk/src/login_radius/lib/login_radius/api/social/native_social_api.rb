# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # NativeSocialApi module
  class NativeSocialApi
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

    # The API is used to get LoginRadius access token by sending Facebook's access token. It will be valid for the specific duration of time specified in the response.
    #
    # @param fb__access__token - Facebook Access Token
    # @param social_app_name - Name of Social provider APP
    #
    # @return Response containing Definition of Complete Token data
    # 20.3
    def get_access_token_by_facebook_access_token(fb__access__token, social_app_name = '')
      if isNullOrWhiteSpace(fb__access__token)
        raise LoginRadius::Error.new, getValidationMessage('fb__access__token')
      end

      query_parameters = {}
      query_parameters['fb_Access_Token'] = fb__access__token
      query_parameters['key'] = @api_key
      unless isNullOrWhiteSpace(social_app_name)
        query_parameters['socialAppName'] = social_app_name
      end

      resource_path = 'api/v2/access_token/facebook'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending Twitter's access token. It will be valid for the specific duration of time specified in the response.
    #
    # @param tw__access__token - Twitter Access Token
    # @param tw__token__secret - Twitter Token Secret
    # @param social_app_name - Name of Social provider APP
    #
    # @return Response containing Definition of Complete Token data
    # 20.4
    def get_access_token_by_twitter_access_token(tw__access__token, tw__token__secret, social_app_name = '')
      if isNullOrWhiteSpace(tw__access__token)
        raise LoginRadius::Error.new, getValidationMessage('tw__access__token')
      end
      if isNullOrWhiteSpace(tw__token__secret)
        raise LoginRadius::Error.new, getValidationMessage('tw__token__secret')
      end

      query_parameters = {}
      query_parameters['key'] = @api_key
      query_parameters['tw_Access_Token'] = tw__access__token
      query_parameters['tw_Token_Secret'] = tw__token__secret
      unless isNullOrWhiteSpace(social_app_name)
        query_parameters['socialAppName'] = social_app_name
      end

      resource_path = 'api/v2/access_token/twitter'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending Google's access token. It will be valid for the specific duration of time specified in the response.
    #
    # @param google__access__token - Google Access Token
    # @param client_id - Google Client ID
    # @param refresh_token - LoginRadius refresh token
    # @param social_app_name - Name of Social provider APP
    #
    # @return Response containing Definition of Complete Token data
    # 20.5
    def get_access_token_by_google_access_token(google__access__token, client_id = '', refresh_token = '', social_app_name = '')
      if isNullOrWhiteSpace(google__access__token)
        raise LoginRadius::Error.new, getValidationMessage('google__access__token')
      end

      query_parameters = {}
      query_parameters['google_Access_Token'] = google__access__token
      query_parameters['key'] = @api_key
      unless isNullOrWhiteSpace(client_id)
        query_parameters['client_id'] = client_id
      end
      unless isNullOrWhiteSpace(refresh_token)
        query_parameters['refresh_token'] = refresh_token
      end
      unless isNullOrWhiteSpace(social_app_name)
        query_parameters['socialAppName'] = social_app_name
      end

      resource_path = 'api/v2/access_token/google'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to Get LoginRadius Access Token using google jwt id token for google native mobile login/registration.
    #
    # @param id__token - Google JWT id_token
    #
    # @return Response containing Definition of Complete Token data
    # 20.6
    def get_access_token_by_google_j_w_t_access_token(id__token)
      if isNullOrWhiteSpace(id__token)
        raise LoginRadius::Error.new, getValidationMessage('id__token')
      end

      query_parameters = {}
      query_parameters['id_Token'] = id__token
      query_parameters['key'] = @api_key

      resource_path = 'api/v2/access_token/googlejwt'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending Linkedin's access token. It will be valid for the specific duration of time specified in the response.
    #
    # @param ln__access__token - Linkedin Access Token
    # @param social_app_name - Name of Social provider APP
    #
    # @return Response containing Definition of Complete Token data
    # 20.7
    def get_access_token_by_linkedin_access_token(ln__access__token, social_app_name = '')
      if isNullOrWhiteSpace(ln__access__token)
        raise LoginRadius::Error.new, getValidationMessage('ln__access__token')
      end

      query_parameters = {}
      query_parameters['key'] = @api_key
      query_parameters['ln_Access_Token'] = ln__access__token
      unless isNullOrWhiteSpace(social_app_name)
        query_parameters['socialAppName'] = social_app_name
      end

      resource_path = 'api/v2/access_token/linkedin'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending Foursquare's access token. It will be valid for the specific duration of time specified in the response.
    #
    # @param fs__access__token - Foursquare Access Token
    #
    # @return Response containing Definition of Complete Token data
    # 20.8
    def get_access_token_by_foursquare_access_token(fs__access__token)
      if isNullOrWhiteSpace(fs__access__token)
        raise LoginRadius::Error.new, getValidationMessage('fs__access__token')
      end

      query_parameters = {}
      query_parameters['fs_Access_Token'] = fs__access__token
      query_parameters['key'] = @api_key

      resource_path = 'api/v2/access_token/foursquare'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending a valid Apple ID OAuth Code. It will be valid for the specific duration of time specified in the response.
    #
    # @param code - Apple Code
    # @param social_app_name - Name of Social provider APP
    #
    # @return Response containing Definition of Complete Token data
    # 20.12
    def get_access_token_by_apple_id_code(code, social_app_name = '')
      if isNullOrWhiteSpace(code)
        raise LoginRadius::Error.new, getValidationMessage('code')
      end

      query_parameters = {}
      query_parameters['code'] = code
      query_parameters['key'] = @api_key
      unless isNullOrWhiteSpace(social_app_name)
        query_parameters['socialAppName'] = social_app_name
      end

      resource_path = 'api/v2/access_token/apple'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve a LoginRadius access token by passing in a valid WeChat OAuth Code.
    #
    # @param code - WeChat Code
    #
    # @return Response containing Definition of Complete Token data
    # 20.13
    def get_access_token_by_we_chat_code(code)
      if isNullOrWhiteSpace(code)
        raise LoginRadius::Error.new, getValidationMessage('code')
      end

      query_parameters = {}
      query_parameters['code'] = code
      query_parameters['key'] = @api_key

      resource_path = 'api/v2/access_token/wechat'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending Vkontakte's access token. It will be valid for the specific duration of time specified in the response.
    #
    # @param vk_access_token - Vkontakte Access Token
    #
    # @return Response containing Definition of Complete Token data
    # 20.15
    def get_access_token_by_vkontakte_access_token(vk_access_token)
      if isNullOrWhiteSpace(vk_access_token)
        raise LoginRadius::Error.new, getValidationMessage('vk_access_token')
      end

      query_parameters = {}
      query_parameters['key'] = @api_key
      query_parameters['vk_access_token'] = vk_access_token

      resource_path = 'api/v2/access_token/vkontakte'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to get LoginRadius access token by sending Google's AuthCode. It will be valid for the specific duration of time specified in the response.
    #
    # @param google_authcode - Google AuthCode
    # @param social_app_name - Name of Social provider APP
    #
    # @return Response containing Definition of Complete Token data
    # 20.16
    def get_access_token_by_google_auth_code(google_authcode, social_app_name = '')
      if isNullOrWhiteSpace(google_authcode)
        raise LoginRadius::Error.new, getValidationMessage('google_authcode')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['google_authcode'] = google_authcode
      unless isNullOrWhiteSpace(social_app_name)
        query_parameters['socialAppName'] = social_app_name
      end

      resource_path = 'api/v2/access_token/google'
      get_request(resource_path, query_parameters, {})
    end
  end
end
