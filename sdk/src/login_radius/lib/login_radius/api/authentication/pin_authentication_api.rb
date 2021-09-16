# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # PINAuthenticationApi module
  class PINAuthenticationApi
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

    # This API is used to login a user by pin and session token.
    #
    # @param login_by_pin_model - Model Class containing Definition of payload for LoginByPin API
    # @param session_token - Session Token of user
    #
    # @return Response containing User Profile Data and access token
    # 9.22
    def pin_login(login_by_pin_model, session_token)
      if login_by_pin_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('login_by_pin_model')
      end
      if isNullOrWhiteSpace(session_token)
        raise LoginRadius::Error.new, getValidationMessage('session_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['session_token'] = session_token

      resource_path = 'identity/v2/auth/login/pin'
      post_request(resource_path, query_parameters, login_by_pin_model)
    end

    # This API sends the reset pin email to specified email address.
    #
    # @param forgot_pin_link_by_email_model - Model Class containing Definition for Forgot Pin Link By Email API
    # @param email_template - Email template name
    # @param reset_pin_url - Reset PIN Url
    #
    # @return Response containing Definition of Complete Validation data
    # 42.1
    def send_forgot_pin_email_by_email(forgot_pin_link_by_email_model, email_template = '', reset_pin_url = '')
      if forgot_pin_link_by_email_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('forgot_pin_link_by_email_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(reset_pin_url)
        query_parameters['resetPINUrl'] = reset_pin_url
      end

      resource_path = 'identity/v2/auth/pin/forgot/email'
      post_request(resource_path, query_parameters, forgot_pin_link_by_email_model)
    end

    # This API sends the reset pin email using username.
    #
    # @param forgot_pin_link_by_user_name_model - Model Class containing Definition for Forgot Pin Link By UserName API
    # @param email_template - Email template name
    # @param reset_pin_url - Reset PIN Url
    #
    # @return Response containing Definition of Complete Validation data
    # 42.2
    def send_forgot_pin_email_by_username(forgot_pin_link_by_user_name_model, email_template = '', reset_pin_url = '')
      if forgot_pin_link_by_user_name_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('forgot_pin_link_by_user_name_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(reset_pin_url)
        query_parameters['resetPINUrl'] = reset_pin_url
      end

      resource_path = 'identity/v2/auth/pin/forgot/username'
      post_request(resource_path, query_parameters, forgot_pin_link_by_user_name_model)
    end

    # This API is used to reset pin using reset token.
    #
    # @param reset_pin_by_reset_token - Model Class containing Definition of payload for Reset Pin By Reset Token API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.3
    def reset_pin_by_reset_token(reset_pin_by_reset_token)
      if reset_pin_by_reset_token.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_reset_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/token'
      put_request(resource_path, query_parameters, reset_pin_by_reset_token)
    end

    # This API is used to reset pin using security question answer and email.
    #
    # @param reset_pin_by_security_question_answer_and_email_model - Model Class containing Definition of payload for Reset Pin By Security Question and Email API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.4
    def reset_pin_by_email_and_security_answer(reset_pin_by_security_question_answer_and_email_model)
      if reset_pin_by_security_question_answer_and_email_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_security_question_answer_and_email_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/securityanswer/email'
      put_request(resource_path, query_parameters, reset_pin_by_security_question_answer_and_email_model)
    end

    # This API is used to reset pin using security question answer and username.
    #
    # @param reset_pin_by_security_question_answer_and_username_model - Model Class containing Definition of payload for Reset Pin By Security Question and UserName API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.5
    def reset_pin_by_username_and_security_answer(reset_pin_by_security_question_answer_and_username_model)
      if reset_pin_by_security_question_answer_and_username_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_security_question_answer_and_username_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/securityanswer/username'
      put_request(resource_path, query_parameters, reset_pin_by_security_question_answer_and_username_model)
    end

    # This API is used to reset pin using security question answer and phone.
    #
    # @param reset_pin_by_security_question_answer_and_phone_model - Model Class containing Definition of payload for Reset Pin By Security Question and Phone API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.6
    def reset_pin_by_phone_and_security_answer(reset_pin_by_security_question_answer_and_phone_model)
      if reset_pin_by_security_question_answer_and_phone_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_security_question_answer_and_phone_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/securityanswer/phone'
      put_request(resource_path, query_parameters, reset_pin_by_security_question_answer_and_phone_model)
    end

    # This API sends the OTP to specified phone number
    #
    # @param forgot_pin_otp_by_phone_model - Model Class containing Definition for Forgot Pin Otp By Phone API
    # @param sms_template - 
    #
    # @return Response Containing Validation Data and SMS Data
    # 42.7
    def send_forgot_pin_sms_by_phone(forgot_pin_otp_by_phone_model, sms_template = '')
      if forgot_pin_otp_by_phone_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('forgot_pin_otp_by_phone_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/pin/forgot/otp'
      post_request(resource_path, query_parameters, forgot_pin_otp_by_phone_model)
    end

    # This API is used to change a user's PIN using access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param change_pin_model - Model Class containing Definition for change PIN Property
    #
    # @return Response containing Definition of Complete Validation data
    # 42.8
    def change_pin_by_access_token(access_token, change_pin_model)
      if isNullOrWhiteSpace(access_token)
        raise LoginRadius::Error.new, getValidationMessage('access_token')
      end
      if change_pin_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('change_pin_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/change'
      put_request(resource_path, query_parameters, change_pin_model)
    end

    # This API is used to reset pin using phoneId and OTP.
    #
    # @param reset_pin_by_phone_and_otp_model - Model Class containing Definition of payload for Reset Pin By Phone and Otp API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.9
    def reset_pin_by_phone_and_otp(reset_pin_by_phone_and_otp_model)
      if reset_pin_by_phone_and_otp_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_phone_and_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/otp/phone'
      put_request(resource_path, query_parameters, reset_pin_by_phone_and_otp_model)
    end

    # This API is used to reset pin using email and OTP.
    #
    # @param reset_pin_by_email_and_otp_model - Model Class containing Definition of payload for Reset Pin By Email and Otp API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.10
    def reset_pin_by_email_and_otp(reset_pin_by_email_and_otp_model)
      if reset_pin_by_email_and_otp_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_email_and_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/otp/email'
      put_request(resource_path, query_parameters, reset_pin_by_email_and_otp_model)
    end

    # This API is used to reset pin using username and OTP.
    #
    # @param reset_pin_by_username_and_otp_model - Model Class containing Definition of payload for Reset Pin By Username and Otp API
    #
    # @return Response containing Definition of Complete Validation data
    # 42.11
    def reset_pin_by_username_and_otp(reset_pin_by_username_and_otp_model)
      if reset_pin_by_username_and_otp_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('reset_pin_by_username_and_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/pin/reset/otp/username'
      put_request(resource_path, query_parameters, reset_pin_by_username_and_otp_model)
    end

    # This API is used to change a user's PIN using Pin Auth token.
    #
    # @param pin_required_model - Model Class containing Definition for PIN
    # @param pin_auth_token - Pin Auth Token
    #
    # @return Response containing User Profile Data and access token
    # 42.12
    def set_pin_by_pin_auth_token(pin_required_model, pin_auth_token)
      if pin_required_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('pin_required_model')
      end
      if isNullOrWhiteSpace(pin_auth_token)
        raise LoginRadius::Error.new, getValidationMessage('pin_auth_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['pinAuthToken'] = pin_auth_token

      resource_path = 'identity/v2/auth/pin/set/pinauthtoken'
      post_request(resource_path, query_parameters, pin_required_model)
    end

    # This API is used to invalidate pin session token.
    #
    # @param session_token - Session Token of user
    #
    # @return Response containing Definition of Complete Validation data
    # 44.1
    def in_validate_pin_session_token(session_token)
      if isNullOrWhiteSpace(session_token)
        raise LoginRadius::Error.new, getValidationMessage('session_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['session_token'] = session_token

      resource_path = 'identity/v2/auth/session_token/invalidate'
      get_request(resource_path, query_parameters, {})
    end
  end
end
