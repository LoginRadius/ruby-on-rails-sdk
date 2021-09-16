# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # OneTouchLoginApi module
  class OneTouchLoginApi
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

    # This API is used to send a link to a specified email for a frictionless login/registration
    #
    # @param one_touch_login_by_email_model - Model Class containing Definition of payload for OneTouchLogin By EmailModel API
    # @param one_touch_login_email_template - Name of the One Touch Login Email Template
    # @param redirecturl - Url where the user will redirect after success authentication
    # @param welcomeemailtemplate - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation data
    # 1.2
    def one_touch_login_by_email(one_touch_login_by_email_model, one_touch_login_email_template = '', redirecturl = '', welcomeemailtemplate = '')
      if one_touch_login_by_email_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('one_touch_login_by_email_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(one_touch_login_email_template)
        query_parameters['oneTouchLoginEmailTemplate'] = one_touch_login_email_template
      end
      unless isNullOrWhiteSpace(redirecturl)
        query_parameters['redirecturl'] = redirecturl
      end
      unless isNullOrWhiteSpace(welcomeemailtemplate)
        query_parameters['welcomeemailtemplate'] = welcomeemailtemplate
      end

      resource_path = 'identity/v2/auth/onetouchlogin/email'
      post_request(resource_path, query_parameters, one_touch_login_by_email_model)
    end

    # This API is used to send one time password to a given phone number for a frictionless login/registration.
    #
    # @param one_touch_login_by_phone_model - Model Class containing Definition of payload for OneTouchLogin By PhoneModel API
    # @param sms_template - SMS Template name
    #
    # @return Response containing Definition of Complete Validation data
    # 1.4
    def one_touch_login_by_phone(one_touch_login_by_phone_model, sms_template = '')
      if one_touch_login_by_phone_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('one_touch_login_by_phone_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/onetouchlogin/phone'
      post_request(resource_path, query_parameters, one_touch_login_by_phone_model)
    end

    # This API is used to verify the otp for One Touch Login.
    #
    # @param otp - The Verification Code
    # @param phone - New Phone Number
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param sms_template - SMS Template name
    #
    # @return Response Containing Access Token and Complete Profile Data
    # 1.5
    def one_touch_login_otp_verification(otp, phone, fields = '', sms_template = '')
      if isNullOrWhiteSpace(otp)
        raise LoginRadius::Error.new, getValidationMessage('otp')
      end
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['otp'] = otp
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      body_parameters = {}
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/onetouchlogin/phone/verify'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API verifies the provided token for One Touch Login
    #
    # @param verification_token - Verification token received in the email
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Complete verified response data
    # 8.4.2
    def one_touch_email_verification(verification_token, welcome_email_template = '')
      if isNullOrWhiteSpace(verification_token)
        raise LoginRadius::Error.new, getValidationMessage('verification_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['verificationToken'] = verification_token
      unless isNullOrWhiteSpace(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/email/onetouchlogin'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to check if the One Touch Login link has been clicked or not.
    #
    # @param client_guid - Unique string used in the Smart Login request
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing User Profile Data and access token
    # 9.21.2
    def one_touch_login_ping(client_guid, fields = '')
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
      get_request(resource_path, query_parameters, {})
    end
  end
end
