# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # CustomObjectApi module
  class CustomObjectApi
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

    # This API is used to write information in JSON format to the custom object for the specified account.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param object_name - LoginRadius Custom Object Name
    # @param payload - LoginRadius Custom Object Name
    #
    # @return Response containing Definition for Complete user custom object data
    # 6.1
    def create_custom_object_by_token(access_token, object_name, payload)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if payload.blank?
        raise LoginRadius::Error.new, getValidationMessage('payload')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/auth/customobject'
      post_request(resource_path, query_parameters, payload)
    end

    # This API is used to update the specified custom object data of the specified account. If the value of updatetype is 'replace' then it will fully replace custom object with the new custom object and if the value of updatetype is 'partialreplace' then it will perform an upsert type operation
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param object_name - LoginRadius Custom Object Name
    # @param object_record_id - Unique identifier of the user's record in Custom Object
    # @param payload - LoginRadius Custom Object Name
    # @param update_type - Possible values: replace, partialreplace.
    #
    # @return Response containing Definition for Complete user custom object data
    # 6.2
    def update_custom_object_by_token(access_token, object_name, object_record_id, payload, update_type = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(object_record_id)
        raise LoginRadius::Error.new, getValidationMessage('object_record_id')
      end
      if payload.blank?
        raise LoginRadius::Error.new, getValidationMessage('payload')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['objectName'] = object_name
      unless update_type == false
        query_parameters['updateType'] = update_type
      end

      resource_path = 'identity/v2/auth/customobject/' + object_record_id
      put_request(resource_path, query_parameters, payload)
    end

    # This API is used to retrieve the specified Custom Object data for the specified account.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param object_name - LoginRadius Custom Object Name
    #
    # @return Complete user CustomObject data
    # 6.3
    def get_custom_object_by_token(access_token, object_name)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/auth/customobject'
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to retrieve the Custom Object data for the specified account.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param object_name - LoginRadius Custom Object Name
    # @param object_record_id - Unique identifier of the user's record in Custom Object
    #
    # @return Response containing Definition for Complete user custom object data
    # 6.4
    def get_custom_object_by_record_id_and_token(access_token, object_name, object_record_id)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(object_record_id)
        raise LoginRadius::Error.new, getValidationMessage('object_record_id')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/auth/customobject/' + object_record_id
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to remove the specified Custom Object data using ObjectRecordId of a specified account.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param object_name - LoginRadius Custom Object Name
    # @param object_record_id - Unique identifier of the user's record in Custom Object
    #
    # @return Response containing Definition of Delete Request
    # 6.5
    def delete_custom_object_by_token(access_token, object_name, object_record_id)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(object_record_id)
        raise LoginRadius::Error.new, getValidationMessage('object_record_id')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/auth/customobject/' + object_record_id
      delete_request(resource_path, query_parameters, nil)
    end

    # This API is used to write information in JSON format to the custom object for the specified account.
    #
    # @param object_name - LoginRadius Custom Object Name
    # @param payload - LoginRadius Custom Object Name
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition for Complete user custom object data
    # 19.1
    def create_custom_object_by_uid(object_name, payload, uid)
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if payload.blank?
        raise LoginRadius::Error.new, getValidationMessage('payload')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/manage/account/' + uid + '/customobject'
      post_request(resource_path, query_parameters, payload)
    end

    # This API is used to update the specified custom object data of a specified account. If the value of updatetype is 'replace' then it will fully replace custom object with new custom object and if the value of updatetype is partialreplace then it will perform an upsert type operation.
    #
    # @param object_name - LoginRadius Custom Object Name
    # @param object_record_id - Unique identifier of the user's record in Custom Object
    # @param payload - LoginRadius Custom Object Name
    # @param uid - UID, the unified identifier for each user account
    # @param update_type - Possible values: replace, partialreplace.
    #
    # @return Response containing Definition for Complete user custom object data
    # 19.2
    def update_custom_object_by_uid(object_name, object_record_id, payload, uid, update_type = '')
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(object_record_id)
        raise LoginRadius::Error.new, getValidationMessage('object_record_id')
      end
      if payload.blank?
        raise LoginRadius::Error.new, getValidationMessage('payload')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['objectName'] = object_name
      unless update_type == false
        query_parameters['updateType'] = update_type
      end

      resource_path = 'identity/v2/manage/account/' + uid + '/customobject/' + object_record_id
      put_request(resource_path, query_parameters, payload)
    end

    # This API is used to retrieve all the custom objects by UID from cloud storage.
    #
    # @param object_name - LoginRadius Custom Object Name
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Complete user CustomObject data
    # 19.3
    def get_custom_object_by_uid(object_name, uid)
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/manage/account/' + uid + '/customobject'
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to retrieve the Custom Object data for the specified account.
    #
    # @param object_name - LoginRadius Custom Object Name
    # @param object_record_id - Unique identifier of the user's record in Custom Object
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition for Complete user custom object data
    # 19.4
    def get_custom_object_by_record_id(object_name, object_record_id, uid)
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(object_record_id)
        raise LoginRadius::Error.new, getValidationMessage('object_record_id')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/manage/account/' + uid + '/customobject/' + object_record_id
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to remove the specified Custom Object data using ObjectRecordId of specified account.
    #
    # @param object_name - LoginRadius Custom Object Name
    # @param object_record_id - Unique identifier of the user's record in Custom Object
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 19.5
    def delete_custom_object_by_record_id(object_name, object_record_id, uid)
      if isNullOrWhiteSpace(object_name)
        raise LoginRadius::Error.new, getValidationMessage('object_name')
      end
      if isNullOrWhiteSpace(object_record_id)
        raise LoginRadius::Error.new, getValidationMessage('object_record_id')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['objectName'] = object_name

      resource_path = 'identity/v2/manage/account/' + uid + '/customobject/' + object_record_id
      delete_request(resource_path, query_parameters, nil)
    end
  end
end
