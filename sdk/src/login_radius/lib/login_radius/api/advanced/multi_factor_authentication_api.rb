# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # MultiFactorAuthenticationApi module
  class MultiFactorAuthenticationApi
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

    # This API is used to configure the Multi-factor authentication after login by using the access token when MFA is set as optional on the LoginRadius site.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Response containing Definition of Complete Multi-Factor Authentication Settings data
    # 5.7
    def mfa_configure_by_access_token(access_token, sms_template2_f_a = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      resource_path = 'identity/v2/auth/account/2fa'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to trigger the Multi-factor authentication settings after login for secure actions
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param multi_factor_auth_model_with_lockout - Model Class containing Definition of payload for MultiFactorAuthModel With Lockout API
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 5.9
    def mfa_update_setting(access_token, multi_factor_auth_model_with_lockout, fields = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if multi_factor_auth_model_with_lockout.blank?
        raise LoginRadius::Error.new, get_validation_message('multi_factor_auth_model_with_lockout')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/auth/account/2fa/verification/otp'
      put_request(resource_path, query_parameters, multi_factor_auth_model_with_lockout)
    end

    # This API is used to Enable Multi-factor authentication by access token on user login
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param multi_factor_auth_model_by_google_authenticator_code - Model Class containing Definition of payload for MultiFactorAuthModel By GoogleAuthenticator Code API
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param sms_template - SMS Template name
    #
    # @return Response containing Definition for Complete profile data
    # 5.10
    def mfa_update_by_access_token(access_token, multi_factor_auth_model_by_google_authenticator_code, fields = '', sms_template = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if multi_factor_auth_model_by_google_authenticator_code.blank?
        raise LoginRadius::Error.new, get_validation_message('multi_factor_auth_model_by_google_authenticator_code')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/auth/account/2fa/verification/googleauthenticatorcode'
      put_request(resource_path, query_parameters, multi_factor_auth_model_by_google_authenticator_code)
    end

    # This API is used to update the Multi-factor authentication phone number by sending the verification OTP to the provided phone number
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param phone_no2_f_a - Phone Number For 2FA
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Response containing Definition for Complete SMS data
    # 5.11
    def mfa_update_phone_number_by_token(access_token, phone_no2_f_a, sms_template2_f_a = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(phone_no2_f_a)
        raise LoginRadius::Error.new, get_validation_message('phone_no2_f_a')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      body_parameters = {}
      body_parameters['phoneNo2FA'] = phone_no2_f_a

      resource_path = 'identity/v2/auth/account/2fa'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API Resets the Google Authenticator configurations on a given account via the access token
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param googleauthenticator - boolean type value,Enable google Authenticator Code.
    #
    # @return Response containing Definition of Delete Request
    # 5.12.1
    def mfa_reset_google_auth_by_token(access_token, googleauthenticator)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['googleauthenticator'] = googleauthenticator

      resource_path = 'identity/v2/auth/account/2fa/authenticator'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API resets the SMS Authenticator configurations on a given account via the access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param otpauthenticator - Pass 'otpauthenticator' to remove SMS Authenticator
    #
    # @return Response containing Definition of Delete Request
    # 5.12.2
    def mfa_reset_sms_auth_by_token(access_token, otpauthenticator)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['otpauthenticator'] = otpauthenticator

      resource_path = 'identity/v2/auth/account/2fa/authenticator'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to get a set of backup codes via access token to allow the user login on a site that has Multi-factor Authentication enabled in the event that the user does not have a secondary factor available. We generate 10 codes, each code can only be consumed once. If any user attempts to go over the number of invalid login attempts configured in the Dashboard then the account gets blocked automatically
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition of Complete Backup Code data
    # 5.13
    def mfa_backup_code_by_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/2fa/backupcode'
      get_request(resource_path, query_parameters, {})
    end

    # API is used to reset the backup codes on a given account via the access token. This API call will generate 10 new codes, each code can only be consumed once
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition of Complete Backup Code data
    # 5.14
    def mfa_reset_backup_code_by_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/2fa/backupcode/reset'
      get_request(resource_path, query_parameters, {})
    end

    # This API is created to send the OTP to the email if email OTP authenticator is enabled in app's MFA configuration.
    #
    # @param access_token - access_token
    # @param email_id - EmailId
    # @param email_template2_f_a - EmailTemplate2FA
    #
    # @return Response containing Definition of Complete Validation data
    # 5.17
    def mfa_email_otp_by_access_token(access_token, email_id, email_template2_f_a = '')
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

      resource_path = 'identity/v2/auth/account/2fa/otp/email'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to set up MFA Email OTP authenticator on profile after login.
    #
    # @param access_token - access_token
    # @param multi_factor_auth_model_by_email_otp_with_lockout - payload
    #
    # @return Response containing Definition for Complete profile data
    # 5.18
    def mfa_validate_email_otp_by_access_token(access_token, multi_factor_auth_model_by_email_otp_with_lockout)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if multi_factor_auth_model_by_email_otp_with_lockout.blank?
        raise LoginRadius::Error.new, get_validation_message('multi_factor_auth_model_by_email_otp_with_lockout')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/2fa/verification/otp/email'
      put_request(resource_path, query_parameters, multi_factor_auth_model_by_email_otp_with_lockout)
    end

    # This API is used to reset the Email OTP Authenticator settings for an MFA-enabled user
    #
    # @param access_token - access_token
    #
    # @return Response containing Definition of Delete Request
    # 5.19
    def mfa_reset_email_otp_authenticator_by_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/2fa/authenticator/otp/email'
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to set up MFA Security Question authenticator on profile after login.
    #
    # @param access_token - access_token
    # @param security_question_answer_model_by_access_token - payload
    #
    # @return Response containing Definition of Complete Validation data
    # 5.20
    def mfa_security_question_answer_by_access_token(access_token, security_question_answer_model_by_access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if security_question_answer_model_by_access_token.blank?
        raise LoginRadius::Error.new, get_validation_message('security_question_answer_model_by_access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/2fa/securityquestionanswer'
      put_request(resource_path, query_parameters, security_question_answer_model_by_access_token)
    end

    # This API is used to Reset MFA Security Question Authenticator By Access Token
    #
    # @param access_token - access_token
    #
    # @return Response containing Definition of Delete Request
    # 5.21
    def mfa_reset_security_question_authenticator_by_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/2fa/authenticator/securityquestionanswer'
      delete_request(resource_path, query_parameters, {})
    end

    # This API can be used to login by emailid on a Multi-factor authentication enabled LoginRadius site.
    #
    # @param email - user's email
    # @param password - Password for the email
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param sms_template - SMS Template name
    # @param sms_template2_f_a - SMS Template Name
    # @param verification_url - Email verification url
    # @param email_template2_f_a - 2FA Email Template name
    #
    # @return Complete user UserProfile data
    # 9.8.1
    def mfa_login_by_email(email, password, email_template = '', fields = '', login_url = '', sms_template = '', sms_template2_f_a = '', verification_url = '', email_template2_f_a = '')
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end
      if is_null_or_white_space(password)
        raise LoginRadius::Error.new, get_validation_message('password')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless is_null_or_white_space(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(email_template2_f_a)
        query_parameters['emailTemplate2FA'] = email_template2_f_a
      end

      body_parameters = {}
      body_parameters['email'] = email
      body_parameters['password'] = password

      resource_path = 'identity/v2/auth/login/2fa'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API can be used to login by username on a Multi-factor authentication enabled LoginRadius site.
    #
    # @param password - Password for the email
    # @param username - Username of the user
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param sms_template - SMS Template name
    # @param sms_template2_f_a - SMS Template Name
    # @param verification_url - Email verification url
    # @param email_template2_f_a - 2FA Email Template name
    #
    # @return Complete user UserProfile data
    # 9.8.2
    def mfa_login_by_user_name(password, username, email_template = '', fields = '', login_url = '', sms_template = '', sms_template2_f_a = '', verification_url = '', email_template2_f_a = '')
      if is_null_or_white_space(password)
        raise LoginRadius::Error.new, get_validation_message('password')
      end
      if is_null_or_white_space(username)
        raise LoginRadius::Error.new, get_validation_message('username')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless is_null_or_white_space(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(email_template2_f_a)
        query_parameters['emailTemplate2FA'] = email_template2_f_a
      end

      body_parameters = {}
      body_parameters['password'] = password
      body_parameters['username'] = username

      resource_path = 'identity/v2/auth/login/2fa'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API can be used to login by Phone on a Multi-factor authentication enabled LoginRadius site.
    #
    # @param password - Password for the email
    # @param phone - New Phone Number
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param sms_template - SMS Template name
    # @param sms_template2_f_a - SMS Template Name
    # @param verification_url - Email verification url
    # @param email_template2_f_a - 2FA Email Template name
    #
    # @return Complete user UserProfile data
    # 9.8.3
    def mfa_login_by_phone(password, phone, email_template = '', fields = '', login_url = '', sms_template = '', sms_template2_f_a = '', verification_url = '', email_template2_f_a = '')
      if is_null_or_white_space(password)
        raise LoginRadius::Error.new, get_validation_message('password')
      end
      if is_null_or_white_space(phone)
        raise LoginRadius::Error.new, get_validation_message('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless is_null_or_white_space(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(email_template2_f_a)
        query_parameters['emailTemplate2FA'] = email_template2_f_a
      end

      body_parameters = {}
      body_parameters['password'] = password
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/login/2fa'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to login via Multi-factor authentication by passing the One Time Password received via SMS
    #
    # @param multi_factor_auth_model_with_lockout - Model Class containing Definition of payload for MultiFactorAuthModel With Lockout API
    # @param second_factor_authentication_token - A Uniquely generated MFA identifier token after successful authentication
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param sms_template2_f_a - SMS Template Name
    # @param rba_browser_email_template - 
    # @param rba_city_email_template - 
    # @param rba_country_email_template - 
    # @param rba_ip_email_template - 
    #
    # @return Complete user UserProfile data
    # 9.12
    def mfa_validate_otp_by_phone(multi_factor_auth_model_with_lockout, second_factor_authentication_token, fields = '', sms_template2_f_a = '' ,rba_browser_email_template = '', rba_city_email_template = '', rba_country_email_template = '', rba_ip_email_template = '')
      if multi_factor_auth_model_with_lockout.blank?
        raise LoginRadius::Error.new, get_validation_message('multi_factor_auth_model_with_lockout')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end
      unless is_null_or_white_space(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless is_null_or_white_space(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless is_null_or_white_space(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless is_null_or_white_space(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end

      resource_path = 'identity/v2/auth/login/2fa/verification/otp'
      put_request(resource_path, query_parameters, multi_factor_auth_model_with_lockout)
    end

    # This API is used to login via Multi-factor-authentication by passing the google authenticator code.
    #
    # @param google_authenticator_code - The code generated by google authenticator app after scanning QR code
    # @param second_factor_authentication_token - SecondFactorAuthenticationToken
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param rba_browser_email_template - RbaBrowserEmailTemplate
    # @param rba_city_email_template - RbaCityEmailTemplate
    # @param rba_country_email_template - RbaCountryEmailTemplate
    # @param rba_ip_email_template - RbaIpEmailTemplate
    #
    # @return Complete user UserProfile data
    # 9.13
    def mfa_validate_google_auth_code(google_authenticator_code, second_factor_authentication_token, fields = '', rba_browser_email_template = '', rba_city_email_template = '', rba_country_email_template = '', rba_ip_email_template = '')
      if is_null_or_white_space(google_authenticator_code)
        raise LoginRadius::Error.new, get_validation_message('google_authenticator_code')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless is_null_or_white_space(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless is_null_or_white_space(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless is_null_or_white_space(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end

      body_parameters = {}
      body_parameters['googleAuthenticatorCode'] = google_authenticator_code

      resource_path = 'identity/v2/auth/login/2fa/verification/googleauthenticatorcode'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to validate the backup code provided by the user and if valid, we return an access token allowing the user to login incases where Multi-factor authentication (MFA) is enabled and the secondary factor is unavailable. When a user initially downloads the Backup codes, We generate 10 codes, each code can only be consumed once. if any user attempts to go over the number of invalid login attempts configured in the Dashboard then the account gets blocked automatically
    #
    # @param multi_factor_auth_model_by_backup_code - Model Class containing Definition of payload for MultiFactorAuth By BackupCode API
    # @param second_factor_authentication_token - A Uniquely generated MFA identifier token after successful authentication
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param rba_browser_email_template - 
    # @param rba_city_email_template - 
    # @param rba_country_email_template - 
    # @param rba_ip_email_template - 
    #
    # @return Complete user UserProfile data
    # 9.14
    def mfa_validate_backup_code(multi_factor_auth_model_by_backup_code, second_factor_authentication_token, fields = '', rba_browser_email_template = '', rba_city_email_template = '', rba_country_email_template = '', rba_ip_email_template = '')
      if multi_factor_auth_model_by_backup_code.blank?
        raise LoginRadius::Error.new, get_validation_message('multi_factor_auth_model_by_backup_code')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless is_null_or_white_space(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless is_null_or_white_space(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless is_null_or_white_space(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end

      resource_path = 'identity/v2/auth/login/2fa/verification/backupcode'
      put_request(resource_path, query_parameters, multi_factor_auth_model_by_backup_code)
    end

    # This API is used to update (if configured) the phone number used for Multi-factor authentication by sending the verification OTP to the provided phone number
    #
    # @param phone_no2_f_a - Phone Number For 2FA
    # @param second_factor_authentication_token - A Uniquely generated MFA identifier token after successful authentication
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Response containing Definition for Complete SMS data
    # 9.16
    def mfa_update_phone_number(phone_no2_f_a, second_factor_authentication_token, sms_template2_f_a = '')
      if is_null_or_white_space(phone_no2_f_a)
        raise LoginRadius::Error.new, get_validation_message('phone_no2_f_a')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      body_parameters = {}
      body_parameters['phoneNo2FA'] = phone_no2_f_a

      resource_path = 'identity/v2/auth/login/2fa'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to resending the verification OTP to the provided phone number
    #
    # @param second_factor_authentication_token - A Uniquely generated MFA identifier token after successful authentication
    # @param sms_template2_f_a - SMS Template Name
    #
    # @return Response containing Definition for Complete SMS data
    # 9.17
    def mfa_resend_otp(second_factor_authentication_token, sms_template2_f_a = '')
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(sms_template2_f_a)
        query_parameters['smsTemplate2FA'] = sms_template2_f_a
      end

      resource_path = 'identity/v2/auth/login/2fa/resend'
      get_request(resource_path, query_parameters, {})
    end

    # An API designed to send the MFA Email OTP to the email.
    #
    # @param email_id_model - payload
    # @param second_factor_authentication_token - SecondFactorAuthenticationToken
    # @param email_template2_f_a - EmailTemplate2FA
    #
    # @return Response containing Definition of Complete Validation data
    # 9.18
    def mfa_email_otp(email_id_model, second_factor_authentication_token, email_template2_f_a = '')
      if email_id_model.blank?
        raise LoginRadius::Error.new, get_validation_message('email_id_model')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(email_template2_f_a)
        query_parameters['emailTemplate2FA'] = email_template2_f_a
      end

      resource_path = 'identity/v2/auth/login/2fa/otp/email'
      post_request(resource_path, query_parameters, email_id_model)
    end

    # This API is used to Verify MFA Email OTP by MFA Token
    #
    # @param multi_factor_auth_model_by_email_otp - payload
    # @param second_factor_authentication_token - SecondFactorAuthenticationToken
    # @param rba_browser_email_template - RbaBrowserEmailTemplate
    # @param rba_city_email_template - RbaCityEmailTemplate
    # @param rba_country_email_template - RbaCountryEmailTemplate
    # @param rba_ip_email_template - RbaIpEmailTemplate
    #
    # @return Response Containing Access Token and Complete Profile Data
    # 9.25
    def mfa_validate_email_otp(multi_factor_auth_model_by_email_otp, second_factor_authentication_token, rba_browser_email_template = '', rba_city_email_template = '', rba_country_email_template = '', rba_ip_email_template = '')
      if multi_factor_auth_model_by_email_otp.blank?
        raise LoginRadius::Error.new, get_validation_message('multi_factor_auth_model_by_email_otp')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless is_null_or_white_space(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless is_null_or_white_space(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless is_null_or_white_space(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end

      resource_path = 'identity/v2/auth/login/2fa/verification/otp/email'
      put_request(resource_path, query_parameters, multi_factor_auth_model_by_email_otp)
    end

    # This API is used to set the security questions on the profile with the MFA token when MFA flow is required.
    #
    # @param security_question_answer_update_model - payload
    # @param second_factor_authentication_token - SecondFactorAuthenticationToken
    #
    # @return Response Containing Access Token and Complete Profile Data
    # 9.26
    def mfa_security_question_answer(security_question_answer_update_model, second_factor_authentication_token)
      if security_question_answer_update_model.blank?
        raise LoginRadius::Error.new, get_validation_message('security_question_answer_update_model')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token

      resource_path = 'identity/v2/auth/login/2fa/securityquestionanswer'
      put_request(resource_path, query_parameters, security_question_answer_update_model)
    end

    # This API is used to resending the verification OTP to the provided phone number
    #
    # @param security_question_answer_update_model - payload
    # @param second_factor_authentication_token - SecondFactorAuthenticationToken
    # @param rba_browser_email_template - RbaBrowserEmailTemplate
    # @param rba_city_email_template - RbaCityEmailTemplate
    # @param rba_country_email_template - RbaCountryEmailTemplate
    # @param rba_ip_email_template - RbaIpEmailTemplate
    #
    # @return Response Containing Access Token and Complete Profile Data
    # 9.27
    def mfa_security_question_answer_verification(security_question_answer_update_model, second_factor_authentication_token, rba_browser_email_template = '', rba_city_email_template = '', rba_country_email_template = '', rba_ip_email_template = '')
      if security_question_answer_update_model.blank?
        raise LoginRadius::Error.new, get_validation_message('security_question_answer_update_model')
      end
      if is_null_or_white_space(second_factor_authentication_token)
        raise LoginRadius::Error.new, get_validation_message('second_factor_authentication_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['secondFactorAuthenticationToken'] = second_factor_authentication_token
      unless is_null_or_white_space(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless is_null_or_white_space(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless is_null_or_white_space(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless is_null_or_white_space(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end

      resource_path = 'identity/v2/auth/login/2fa/verification/securityquestionanswer'
      post_request(resource_path, query_parameters, security_question_answer_update_model)
    end

    # This API resets the SMS Authenticator configurations on a given account via the UID.
    #
    # @param otpauthenticator - Pass 'otpauthenticator' to remove SMS Authenticator
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.21.1
    def mfa_reset_sms_authenticator_by_uid(otpauthenticator, uid)
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      body_parameters = {}
      body_parameters['otpauthenticator'] = otpauthenticator

      resource_path = 'identity/v2/manage/account/2fa/authenticator'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API resets the Google Authenticator configurations on a given account via the UID.
    #
    # @param googleauthenticator - boolean type value,Enable google Authenticator Code.
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.21.2
    def mfa_reset_google_authenticator_by_uid(googleauthenticator, uid)
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      body_parameters = {}
      body_parameters['googleauthenticator'] = googleauthenticator

      resource_path = 'identity/v2/manage/account/2fa/authenticator'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to reset the backup codes on a given account via the UID. This API call will generate 10 new codes, each code can only be consumed once.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Backup Code data
    # 18.25
    def mfa_backup_code_by_uid(uid)
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      resource_path = 'identity/v2/manage/account/2fa/backupcode'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to reset the backup codes on a given account via the UID. This API call will generate 10 new codes, each code can only be consumed once.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Backup Code data
    # 18.26
    def mfa_reset_backup_code_by_uid(uid)
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      resource_path = 'identity/v2/manage/account/2fa/backupcode/reset'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to reset the Email OTP Authenticator settings for an MFA-enabled user.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.42
    def mfa_reset_email_otp_authenticator_by_uid(uid)
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      resource_path = 'identity/v2/manage/account/2fa/authenticator/otp/email'
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to reset the Security Question Authenticator settings for an MFA-enabled user.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.43
    def mfa_reset_security_question_authenticator_by_uid(uid)
      if is_null_or_white_space(uid)
        raise LoginRadius::Error.new, get_validation_message('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      resource_path = 'identity/v2/manage/account/2fa/authenticator/securityquestionanswer'
      delete_request(resource_path, query_parameters, {})
    end
  end
end
