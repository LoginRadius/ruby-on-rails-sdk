# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # ReAuthenticationApi module
  class ReAuthenticationApi
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

    # This API is used to trigger the Multi-Factor Autentication workflow for the provided access token
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Response containing Definition of Complete Multi-Factor Authentication Settings data
    # 14.3
    def mfa_re_authenticate(access_token, sms_template2_f_a = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      resource_path = 'identity/v2/auth/account/reauth/2fa'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to re-authenticate via Multi-factor authentication by passing the One Time Password received via SMS
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param reauth_by_otp_model - Model Class containing Definition for MFA Reauthentication by OTP
    #
    # @return Complete user Multi-Factor Authentication Token data
    # 14.4
    def mfa_re_authenticate_by_otp(access_token, reauth_by_otp_model)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if reauth_by_otp_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reauth_by_otp_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/reauth/2fa/otp'
      put_request(resource_path, query_parameters, reauth_by_otp_model)
    end

    # This API is used to re-authenticate by set of backup codes via access token on the site that has Multi-factor authentication enabled in re-authentication for the user that does not have the device
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param reauth_by_backup_code_model - Model Class containing Definition for MFA Reauthentication by Backup code
    #
    # @return Complete user Multi-Factor Authentication Token data
    # 14.5
    def mfa_re_authenticate_by_backup_code(access_token, reauth_by_backup_code_model)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if reauth_by_backup_code_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reauth_by_backup_code_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/reauth/2fa/backupcode'
      put_request(resource_path, query_parameters, reauth_by_backup_code_model)
    end

    # This API is used to re-authenticate via Multi-factor-authentication by passing the google authenticator code
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param reauth_by_google_authenticator_code_model - Model Class containing Definition for MFA Reauthentication by Google Authenticator
    #
    # @return Complete user Multi-Factor Authentication Token data
    # 14.6
    def mfa_re_authenticate_by_google_auth(access_token, reauth_by_google_authenticator_code_model)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if reauth_by_google_authenticator_code_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reauth_by_google_authenticator_code_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/reauth/2fa/googleauthenticatorcode'
      put_request(resource_path, query_parameters, reauth_by_google_authenticator_code_model)
    end

    # This API is used to re-authenticate via Multi-factor-authentication by passing the password
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param password_event_based_auth_model_with_lockout - Model Class containing Definition of payload for PasswordEventBasedAuthModel with Lockout API
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Complete user Multi-Factor Authentication Token data
    # 14.7
    def mfa_re_authenticate_by_password(access_token, password_event_based_auth_model_with_lockout, sms_template2_f_a = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if password_event_based_auth_model_with_lockout.blank?
        raise LoginRadius::Error.new, get_validation_message('password_event_based_auth_model_with_lockout')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      resource_path = 'identity/v2/auth/account/reauth/password'
      put_request(resource_path, query_parameters, password_event_based_auth_model_with_lockout)
    end

    # This API is used on the server-side to validate and verify the re-authentication token created by the MFA re-authentication API. This API checks re-authentications created by OTP.
    #
    # @param event_based_multi_factor_token - Model Class containing Definition for SecondFactorValidationToken
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Validation data
    # 18.38
    def verify_multi_factor_otp_reauthentication(event_based_multi_factor_token, uid)
      if event_based_multi_factor_token.blank?
        raise LoginRadius::Error.new, get_validation_message('event_based_multi_factor_token')
      end
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/reauth/2fa'
      post_request(resource_path, query_parameters, event_based_multi_factor_token)
    end

    # This API is used on the server-side to validate and verify the re-authentication token created by the MFA re-authentication API. This API checks re-authentications created by password.
    #
    # @param event_based_multi_factor_token - Model Class containing Definition for SecondFactorValidationToken
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Validation data
    # 18.39
    def verify_multi_factor_password_reauthentication(event_based_multi_factor_token, uid)
      if event_based_multi_factor_token.blank?
        raise LoginRadius::Error.new, get_validation_message('event_based_multi_factor_token')
      end
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/reauth/password'
      post_request(resource_path, query_parameters, event_based_multi_factor_token)
    end

    # This API is used on the server-side to validate and verify the re-authentication token created by the MFA re-authentication API. This API checks re-authentications created by PIN.
    #
    # @param event_based_multi_factor_token - Model Class containing Definition for SecondFactorValidationToken
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Validation data
    # 18.40
    def verify_multi_factor_pin_reauthentication(event_based_multi_factor_token, uid)
      if event_based_multi_factor_token.blank?
        raise LoginRadius::Error.new, get_validation_message('event_based_multi_factor_token')
      end
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/reauth/pin'
      post_request(resource_path, query_parameters, event_based_multi_factor_token)
    end

    # This API is used to validate the triggered MFA authentication flow with a password.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param pin_auth_event_based_auth_model_with_lockout - Model Class containing Definition of payload for PIN
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Response containing Definition response of MFA reauthentication
    # 42.13
    def verify_pin_authentication(access_token, pin_auth_event_based_auth_model_with_lockout, sms_template2_f_a = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if pin_auth_event_based_auth_model_with_lockout.blank?
        raise LoginRadius::Error.new, get_validation_message('pin_auth_event_based_auth_model_with_lockout')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      resource_path = 'identity/v2/auth/account/reauth/pin'
      put_request(resource_path, query_parameters, pin_auth_event_based_auth_model_with_lockout)
    end

    # This API is used to validate the triggered MFA authentication flow with an Email OTP.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param reauth_by_email_otp_model - payload
    #
    # @return Response containing Definition response of MFA reauthentication
    # 42.14
    def re_auth_validate_email_otp(access_token, reauth_by_email_otp_model)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if reauth_by_email_otp_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reauth_by_email_otp_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/reauth/2fa/otp/email/verify'
      put_request(resource_path, query_parameters, reauth_by_email_otp_model)
    end

    # This API is used to send the MFA Email OTP to the email for Re-authentication
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param email_id - EmailId
    # @param email_template2_f_a - EmailTemplate2FA
    #
    # @return Response containing Definition of Complete Validation data
    # 42.15
    def re_auth_send_email_otp(access_token, email_id, email_template2_f_a = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(email_id)
        raise LoginRadius::Error.new, get_validation_message('email_id')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      query_parameters['emailId'] = email_id
      unless is_null_or_white_space(email_template2_f_a)
        query_parameters['emailTemplate2FA'] = email_template2_f_a
      end

      resource_path = 'identity/v2/auth/account/reauth/2fa/otp/email'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to validate the triggered MFA re-authentication flow with security questions answers.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param security_question_answer_update_model - payload
    #
    # @return Response containing Definition response of MFA reauthentication
    # 42.16
    def re_auth_by_security_question(access_token, security_question_answer_update_model)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if security_question_answer_update_model.blank?
        raise LoginRadius::Error.new, get_validation_message('security_question_answer_update_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/reauth/2fa/securityquestionanswer/verify'
      post_request(resource_path, query_parameters, security_question_answer_update_model)
    end
  end
end
