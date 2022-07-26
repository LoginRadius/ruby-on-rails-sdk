# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # CustomRegistrationDataApi module
  class CustomRegistrationDataApi
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

    # This API is used to retrieve dropdown data.
    #
    # @param type - Type of the Datasource
    # @param limit - Retrieve number of records at a time(max limit is 50)
    # @param parent_id - Id of parent dropdown member(if any).
    # @param skip - Skip number of records from start
    #
    # @return Complete user Registration data
    # 7.1
    def auth_get_registration_data(type, limit = '', parent_id = '', skip = '')
      if is_null_or_white_space(type)
        raise LoginRadius::Error.new, get_validation_message('type')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless limit == false
        query_parameters['limit'] = limit
      end
      unless is_null_or_white_space(parent_id)
        query_parameters['parentId'] = parent_id
      end
      unless skip == false
        query_parameters['skip'] = skip
      end

      resource_path = 'identity/v2/auth/registrationdata/' + type
      get_request(resource_path, query_parameters, {})
    end

    # This API allows you to validate code for a particular dropdown member.
    #
    # @param code - Secret Code
    # @param record_id - Selected dropdown item’s record id
    #
    # @return Response containing Definition of Complete Validation data
    # 7.2
    def validate_registration_data_code(code, record_id)
      if is_null_or_white_space(code)
        raise LoginRadius::Error.new, get_validation_message('code')
      end
      if is_null_or_white_space(record_id)
        raise LoginRadius::Error.new, get_validation_message('record_id')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['code'] = code
      body_parameters['recordId'] = record_id

      resource_path = 'identity/v2/auth/registrationdata/validatecode'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to retrieve dropdown data.
    #
    # @param type - Type of the Datasource
    # @param limit - Retrive number of records at a time(max limit is 50
    # @param parent_id - Id of parent dropdown member(if any).
    # @param skip - Skip number of records from start
    #
    # @return Complete user Registration data Fields
    # 16.1
    def get_registration_data(type, limit = '', parent_id = '', skip = '')
      if is_null_or_white_space(type)
        raise LoginRadius::Error.new, get_validation_message('type')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless limit == false
        query_parameters['limit'] = limit
      end
      unless is_null_or_white_space(parent_id)
        query_parameters['parentId'] = parent_id
      end
      unless skip == false
        query_parameters['skip'] = skip
      end

      resource_path = 'identity/v2/manage/registrationdata/' + type
      get_request(resource_path, query_parameters, {})
    end

    # This API allows you to fill data into a dropdown list which you have created for user Registration. For more details on how to use this API please see our Custom Registration Data Overview
    #
    # @param registration_data_create_model_list - Model Class containing Definition of List of Registration Data
    #
    # @return Response containing Definition of Complete Validation data
    # 16.2
    def add_registration_data(registration_data_create_model_list)
      if registration_data_create_model_list.blank?
        raise LoginRadius::Error.new, get_validation_message('registration_data_create_model_list')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/registrationdata'
      post_request(resource_path, query_parameters, registration_data_create_model_list)
    end

    # This API allows you to update a dropdown item
    #
    # @param registration_data_update_model - Model Class containing Definition of payload for Registration Data update API
    # @param record_id - Registration data RecordId
    #
    # @return Complete user Registration data Field
    # 16.3
    def update_registration_data(registration_data_update_model, record_id)
      if registration_data_update_model.blank?
        raise LoginRadius::Error.new, get_validation_message('registration_data_update_model')
      end
      if is_null_or_white_space(record_id)
        raise LoginRadius::Error.new, get_validation_message('record_id')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/registrationdata/' + record_id
      put_request(resource_path, query_parameters, registration_data_update_model)
    end

    # This API allows you to delete an item from a dropdown list.
    #
    # @param record_id - Registration data RecordId
    #
    # @return Response containing Definition of Delete Request
    # 16.4
    def delete_registration_data(record_id)
      if is_null_or_white_space(record_id)
        raise LoginRadius::Error.new, get_validation_message('record_id')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/registrationdata/' + record_id
      delete_request(resource_path, query_parameters, {})
    end

    # This API allows you to delete all records contained in a datasource.
    #
    # @param type - Type of the Datasource
    #
    # @return Response containing Definition of Delete Request
    # 16.5
    def delete_all_records_by_data_source(type)
      if is_null_or_white_space(type)
        raise LoginRadius::Error.new, get_validation_message('type')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/registrationdata/type/' + type
      delete_request(resource_path, query_parameters, {})
    end
  end
end
