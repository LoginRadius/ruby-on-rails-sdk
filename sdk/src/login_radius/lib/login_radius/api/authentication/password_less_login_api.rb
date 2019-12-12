# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # PasswordLessLoginApi module
  class PasswordLessLoginApi
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

    # This API verifies an account by OTP and allows the customer to login.
    #
    # @param password_less_login_otp_model - Model Class containing Definition of payload for PasswordLessLoginOtpModel API
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param sms_template - SMS Template name
    #
    # @return Response containing User Profile Data and access token
    # 9.6
    def passwordless_login_phone_verification(password_less_login_otp_model, fields = '', sms_template = '')
      if password_less_login_otp_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('password_less_login_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/login/passwordlesslogin/otp/verify'
      put_request(resource_path, query_parameters, password_less_login_otp_model)
    end

    # API can be used to send a One-time Passcode (OTP) provided that the account has a verified PhoneID
    #
    # @param phone - The Registered Phone Number
    # @param sms_template - SMS Template name
    #
    # @return Response Containing Definition of SMS Data
    # 9.15
    def passwordless_login_by_phone(phone, sms_template = '')
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['phone'] = phone
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/login/passwordlesslogin/otp'
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to send a Passwordless Login verification link to the provided Email ID
    #
    # @param email - Email of the user
    # @param password_less_login_template - Passwordless Login Template Name
    # @param verification_url - Email verification url
    #
    # @return Response containing Definition of Complete Validation data
    # 9.18.1
    def passwordless_login_by_email(email, password_less_login_template = '', verification_url = '')
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['email'] = email
      unless isNullOrWhiteSpace(password_less_login_template)
        query_parameters['passwordLessLoginTemplate'] = password_less_login_template
      end
      unless isNullOrWhiteSpace(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/login/passwordlesslogin/email'
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to send a Passwordless Login Verification Link to a customer by providing their UserName
    #
    # @param username - UserName of the user
    # @param password_less_login_template - Passwordless Login Template Name
    # @param verification_url - Email verification url
    #
    # @return Response containing Definition of Complete Validation data
    # 9.18.2
    def passwordless_login_by_user_name(username, password_less_login_template = '', verification_url = '')
      if isNullOrWhiteSpace(username)
        raise LoginRadius::Error.new, getValidationMessage('username')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['username'] = username
      unless isNullOrWhiteSpace(password_less_login_template)
        query_parameters['passwordLessLoginTemplate'] = password_less_login_template
      end
      unless isNullOrWhiteSpace(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/login/passwordlesslogin/email'
      get_request(resource_path, query_parameters, nil)
    end

    # This API is used to verify the Passwordless Login verification link. Note: If you are using Passwordless Login by Phone you will need to use the Passwordless Login Phone Verification API
    #
    # @param verification_token - Verification token received in the email
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing User Profile Data and access token
    # 9.19
    def passwordless_login_verification(verification_token, fields = '', welcome_email_template = '')
      if isNullOrWhiteSpace(verification_token)
        raise LoginRadius::Error.new, getValidationMessage('verification_token')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['verificationToken'] = verification_token
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/login/passwordlesslogin/email/verify'
      get_request(resource_path, query_parameters, nil)
    end
  end
end
