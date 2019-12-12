# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # SmartLoginApi module
  class SmartLoginApi
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

    # This API verifies the provided token for Smart Login
    #
    # @param verification_token - Verification token received in the email
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Complete verified response data
    # 8.4.1
    def smart_login_token_verification(verification_token, welcome_email_template = '')
      if isNullOrWhiteSpace(verification_token)
        raise LoginRadius::Error.new, getValidationMessage('verification_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['verificationToken'] = verification_token
      unless isNullOrWhiteSpace(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/email/smartlogin'
      get_request(resource_path, query_parameters, nil)
    end

    # This API sends a Smart Login link to the user's Email Id.
    #
    # @param client_guid - Unique string used in the Smart Login request
    # @param email - Email of the user
    # @param redirect_url - Url where the user will redirect after success authentication
    # @param smart_login_email_template - Email template for Smart Login link
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation data
    # 9.17.1
    def smart_login_by_email(client_guid, email, redirect_url = '', smart_login_email_template = '', welcome_email_template = '')
      if isNullOrWhiteSpace(client_guid)
        raise LoginRadius::Error.new, getValidationMessage('client_guid')
      end
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['clientGuid'] = client_guid
      query_parameters['email'] = email
      unless isNullOrWhiteSpace(redirect_url)
        query_parameters['redirectUrl'] = redirect_url
      end
      unless isNullOrWhiteSpace(smart_login_email_template)
        query_parameters['smartLoginEmailTemplate'] = smart_login_email_template
      end
      unless isNullOrWhiteSpace(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/login/smartlogin'
      get_request(resource_path, query_parameters, nil)
    end

    # This API sends a Smart Login link to the user's Email Id.
    #
    # @param client_guid - Unique string used in the Smart Login request
    # @param username - UserName of the user
    # @param redirect_url - Url where the user will redirect after success authentication
    # @param smart_login_email_template - Email template for Smart Login link
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation data
    # 9.17.2
    def smart_login_by_user_name(client_guid, username, redirect_url = '', smart_login_email_template = '', welcome_email_template = '')
      if isNullOrWhiteSpace(client_guid)
        raise LoginRadius::Error.new, getValidationMessage('client_guid')
      end
      if isNullOrWhiteSpace(username)
        raise LoginRadius::Error.new, getValidationMessage('username')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['clientGuid'] = client_guid
      query_parameters['username'] = username
      unless isNullOrWhiteSpace(redirect_url)
        query_parameters['redirectUrl'] = redirect_url
      end
      unless isNullOrWhiteSpace(smart_login_email_template)
        query_parameters['smartLoginEmailTemplate'] = smart_login_email_template
      end
      unless isNullOrWhiteSpace(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/login/smartlogin'
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to check if the Smart Login link has been clicked or not
    #
    # @param client_guid - Unique string used in the Smart Login request
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing User Profile Data and access token
    # 9.21.1
    def smart_login_ping(client_guid, fields = '')
      if isNullOrWhiteSpace(client_guid)
        raise LoginRadius::Error.new, getValidationMessage('client_guid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['clientGuid'] = client_guid
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/auth/login/smartlogin/ping'
      get_request(resource_path, query_parameters, nil)
    end
  end
end
