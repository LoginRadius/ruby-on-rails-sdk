# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2025 LoginRadius Inc. All rights reserved.
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
      get_request(resource_path, query_parameters, {})
    end

    # The Refresh Access Token API is used to refresh the provider access token after authentication. It will be valid for up to 60 days on LoginRadius depending on the provider. In order to use the access token in other APIs, always refresh the token using this API.<br><br><b>Supported Providers :</b> Facebook,Yahoo,Google,Twitter, Linkedin.<br><br> Contact LoginRadius support team to enable this API.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param expires_in - Allows you to specify a desired expiration time in minutes for the newly issued access token.
    # @param is_web - Is web or not.
    #
    # @return Response containing Definition of Complete Token data
    # 20.2
    def refresh_access_token(access_token, expires_in, is_web = false)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['secret'] = @api_secret
      unless expires_in == false
        query_parameters['expiresIn'] = expires_in
      end
      unless is_web == false
        query_parameters['isWeb'] = is_web
      end

      resource_path = 'api/v2/access_token/refresh'
      get_request(resource_path, query_parameters, {})
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
      get_request(resource_path, query_parameters, {})
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
      get_request(resource_path, query_parameters, {})
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
      get_request(resource_path, query_parameters, {})
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
      get_request(resource_path, query_parameters, {})
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
      get_request(resource_path, query_parameters, {})
    end
  end
end
