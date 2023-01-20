# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # PhoneAuthenticationApi module
  class PhoneAuthenticationApi
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

    # This API retrieves a copy of the user data based on the Phone
    #
    # @param phone_authentication_model - Model Class containing Definition of payload for PhoneAuthenticationModel API
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param sms_template - SMS Template name
    #
    # @return Response containing User Profile Data and access token
    # 9.2.3
    def login_by_phone(phone_authentication_model, fields = '', login_url = '', sms_template = '')
      if phone_authentication_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('phone_authentication_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/login'
      post_request(resource_path, query_parameters, phone_authentication_model)
    end

    # This API is used to send the OTP to reset the account password.
    #
    # @param phone - New Phone Number
    # @param sms_template - SMS Template name
    #
    # @return Response Containing Validation Data and SMS Data
    # 10.4
    def forgot_password_by_phone_otp(phone, sms_template = '')
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      body_parameters = {}
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/password/otp'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to reset the password
    #
    # @param reset_password_by_otp_model - Model Class containing Definition of payload for ResetPasswordByOTP API
    #
    # @return Response containing Definition of Complete Validation data
    # 10.5
    def reset_password_by_phone_otp(reset_password_by_otp_model)
      if reset_password_by_otp_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_password_by_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/otp'
      put_request(resource_path, query_parameters, reset_password_by_otp_model)
    end

    # This API is used to validate the verification code sent to verify a user's phone number
    #
    # @param otp - The Verification Code
    # @param phone - New Phone Number
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param sms_template - SMS Template name
    #
    # @return Response containing User Profile Data and access token
    # 11.1.1
    def phone_verification_by_otp(otp, phone, fields = '', sms_template = '')
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

      resource_path = 'identity/v2/auth/phone/otp'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to consume the verification code sent to verify a user's phone number. Use this call for front-end purposes in cases where the user is already logged in by passing the user's access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param otp - The Verification Code
    # @param sms_template - SMS Template name
    #
    # @return Response containing Definition of Complete Validation data
    # 11.1.2
    def phone_verification_otp_by_access_token(access_token, otp, sms_template = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(otp)
        raise LoginRadius::Error.new, getValidationMessage('otp')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['otp'] = otp
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/phone/otp'
      put_request(resource_path, query_parameters, {})
    end

    # This API is used to resend a verification OTP to verify a user's Phone Number. The user will receive a verification code that they will need to input
    #
    # @param phone - New Phone Number
    # @param sms_template - SMS Template name
    #
    # @return Response Containing Validation Data and SMS Data
    # 11.2.1
    def phone_resend_verification_otp(phone, sms_template = '')
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      body_parameters = {}
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/phone/otp'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to resend a verification OTP to verify a user's Phone Number in cases in which an active token already exists
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param phone - New Phone Number
    # @param sms_template - SMS Template name
    #
    # @return Response Containing Validation Data and SMS Data
    # 11.2.2
    def phone_resend_verification_otp_by_token(access_token, phone, sms_template = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      body_parameters = {}
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/phone/otp'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to update the login Phone Number of users
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param phone - New Phone Number
    # @param sms_template - SMS Template name
    #
    # @return Response Containing Validation Data and SMS Data
    # 11.5
    def update_phone_number(access_token, phone, sms_template = '')
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      body_parameters = {}
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/phone'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to check the Phone Number exists or not on your site.
    #
    # @param phone - The Registered Phone Number
    #
    # @return Response containing Definition Complete ExistResponse data
    # 11.6
    def check_phone_number_availability(phone)
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/phone'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to delete the Phone ID on a user's account via the access token
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition of Delete Request
    # 11.7
    def remove_phone_id_by_access_token(access_token)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/phone'
      delete_request(resource_path, query_parameters, {})
    end

    # This API registers the new users into your Cloud Storage and triggers the phone verification process.
    #
    # @param auth_user_registration_model - Model Class containing Definition of payload for Auth User Registration API
    # @param sott - LoginRadius Secured One Time Token
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param options - PreventVerificationEmail (Specifying this value prevents the verification email from being sent. Only applicable if you have the optional email verification flow)
    # @param sms_template - SMS Template name
    # @param verification_url - Email verification url
    # @param welcome_email_template - Name of the welcome email template
    # @param email_template - Name of the  email template
    #
    # @return Response containing Definition of Complete Validation, UserProfile data and Access Token
    # 17.1.2
    def user_registration_by_phone(auth_user_registration_model, sott, fields = '', options = '', sms_template = '', verification_url = '', welcome_email_template = '', email_template = '')
      if auth_user_registration_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('auth_user_registration_model')
      end
      if isNullOrWhiteSpace(sott)
        raise LoginRadius::Error.new, getValidationMessage('sott')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['sott'] = sott
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(options)
        query_parameters['options'] = options
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless isNullOrWhiteSpace(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless isNullOrWhiteSpace(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end

      resource_path = 'identity/v2/auth/register'
      post_request(resource_path, query_parameters, auth_user_registration_model)
    end
  end
end
