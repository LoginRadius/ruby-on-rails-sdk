# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # ConsentManagementApi module
  class ConsentManagementApi
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

    # This API is used to get the Consent logs of the user.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing consent logs
    # 18.37
    def get_consent_logs_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/consent/logs'
      get_request(resource_path, query_parameters, {})
    end

    # This API is to submit consent form using consent token.
    #
    # @param consent_token - The consent token received after login error 1226 
    # @param consent_submit_model - Model class containing list of multiple consent
    #
    # @return Response containing User Profile Data and access token
    # 43.1
    def submit_consent_by_consent_token(consent_token, consent_submit_model)
      if isNullOrWhiteSpace(consent_token)
        raise LoginRadius::Error.new, getValidationMessage('consent_token')
      end
      if consent_submit_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('consent_submit_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['consentToken'] = consent_token

      resource_path = 'identity/v2/auth/consent'
      post_request(resource_path, query_parameters, consent_submit_model)
    end

    # This API is used to fetch consent logs.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing consent logs
    # 43.2
    def get_consent_logs(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/consent/logs'
      get_request(resource_path, query_parameters, {})
    end

    # API to provide a way to end user to submit a consent form for particular event type.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param consent_submit_model - Model class containing list of multiple consent
    #
    # @return Response containing Definition for Complete profile data
    # 43.3
    def submit_consent_by_access_token(access_token, consent_submit_model)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if consent_submit_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('consent_submit_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/consent/profile'
      post_request(resource_path, query_parameters, consent_submit_model)
    end

    # This API is used to check if consent is submitted for a particular event or not.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param event - Allowed events: Login, Register, UpdateProfile, ResetPassword, ChangePassword, emailVerification, AddEmail, RemoveEmail, BlockAccount, DeleteAccount, SetUsername, AssignRoles, UnassignRoles, SetPassword, LinkAccount, UnlinkAccount, UpdatePhoneId, VerifyPhoneNumber, CreateCustomObject, UpdateCustomobject, DeleteCustomObject
    # @param is_custom - true/false
    #
    # @return Response containing consent profile
    # 43.4
    def verify_consent_by_access_token(access_token, event, is_custom)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(event)
        raise LoginRadius::Error.new, getValidationMessage('event')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['event'] = event
      query_parameters['isCustom'] = is_custom

      resource_path = 'identity/v2/auth/consent/verify'
      get_request(resource_path, query_parameters, {})
    end

    # This API is to update consents using access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param consent_update_model - Model class containg list of multiple consent
    #
    # @return Response containing consent profile
    # 43.5
    def update_consent_profile_by_access_token(access_token, consent_update_model)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if consent_update_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('consent_update_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/consent'
      put_request(resource_path, query_parameters, consent_update_model)
    end
  end
end
