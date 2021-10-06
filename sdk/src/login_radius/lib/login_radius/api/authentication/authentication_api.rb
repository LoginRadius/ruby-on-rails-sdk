# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # AuthenticationApi module
  class AuthenticationApi
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

    # This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.
    #
    # @param email - Email of the user
    #
    # @return Response containing Definition for Complete SecurityQuestions data
    # 2.1
    def get_security_questions_by_email(email)
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['email'] = email

      resource_path = 'identity/v2/auth/securityquestion/email'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.
    #
    # @param user_name - UserName of the user
    #
    # @return Response containing Definition for Complete SecurityQuestions data
    # 2.2
    def get_security_questions_by_user_name(user_name)
      if is_null_or_white_space(user_name)
        raise LoginRadius::Error.new, get_validation_message('user_name')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['userName'] = user_name

      resource_path = 'identity/v2/auth/securityquestion/username'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.
    #
    # @param phone - The Registered Phone Number
    #
    # @return Response containing Definition for Complete SecurityQuestions data
    # 2.3
    def get_security_questions_by_phone(phone)
      if is_null_or_white_space(phone)
        raise LoginRadius::Error.new, get_validation_message('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['phone'] = phone

      resource_path = 'identity/v2/auth/securityquestion/phone'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition for Complete SecurityQuestions data
    # 2.4
    def get_security_questions_by_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/securityquestion/accesstoken'
      get_request(resource_path, query_parameters, {})
    end

    # This api validates access token, if valid then returns a response with its expiry otherwise error.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition of Complete Token data
    # 4.1
    def auth_validate_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/access_token/validate'
      get_request(resource_path, query_parameters, {})
    end

    # This api call invalidates the active access token or expires an access token's validity.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param prevent_refresh - Boolean value that when set as true, in addition of the access token being invalidated, it will no longer have the capability of being refreshed.
    #
    # @return Response containing Definition of Complete Validation data
    # 4.2
    def auth_in_validate_access_token(access_token, prevent_refresh = false)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless prevent_refresh == false
        query_parameters['preventRefresh'] = prevent_refresh
      end

      resource_path = 'identity/v2/auth/access_token/invalidate'
      get_request(resource_path, query_parameters, {})
    end

    # This api call provide the active access token Information
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Response containing Definition of Token Information
    # 4.3
    def get_access_token_info(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/access_token'
      get_request(resource_path, query_parameters, {})
    end

    # This API retrieves a copy of the user data based on the access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param email_template - 
    # @param verification_url - 
    # @param welcome_email_template - 
    #
    # @return Response containing Definition for Complete profile data
    # 5.2
    def get_profile_by_access_token(access_token, fields = '', email_template = '', verification_url = '', welcome_email_template = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/account'
      get_request(resource_path, query_parameters, {})
    end

    # This API sends a welcome email
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation data
    # 5.3
    def send_welcome_email(access_token, welcome_email_template = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/account/sendwelcomeemail'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to update the user's profile by passing the access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param user_profile_update_model - Model Class containing Definition of payload for User Profile update API
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param null_support - Boolean, pass true if you wish to update any user profile field with a NULL value, You can get the details
    # @param sms_template - SMS Template name
    # @param verification_url - Email verification url
    #
    # @return Response containing Definition of Complete Validation and UserProfile data
    # 5.4
    def update_profile_by_access_token(access_token, user_profile_update_model, email_template = '', fields = '', null_support = false, sms_template = '', verification_url = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if user_profile_update_model.blank?
        raise LoginRadius::Error.new, get_validation_message('user_profile_update_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless null_support == false
        query_parameters['nullSupport'] = null_support
      end
      unless is_null_or_white_space(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/account'
      put_request(resource_path, query_parameters, user_profile_update_model)
    end

    # This API will send a confirmation email for account deletion to the customer's email when passed the customer's access token
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param delete_url - Url of the site
    # @param email_template - Email template name
    #
    # @return Response containing Definition of Delete Request
    # 5.5
    def delete_account_with_email_confirmation(access_token, delete_url = '', email_template = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(delete_url)
        query_parameters['deleteUrl'] = delete_url
      end
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end

      resource_path = 'identity/v2/auth/account'
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to delete an account by passing it a delete token.
    #
    # @param deletetoken - Delete token received in the email
    #
    # @return Response containing Definition of Complete Validation data
    # 5.6
    def delete_account_by_delete_token(deletetoken)
      if is_null_or_white_space(deletetoken)
        raise LoginRadius::Error.new, get_validation_message('deletetoken')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['deletetoken'] = deletetoken

      resource_path = 'identity/v2/auth/account/delete'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to allow a customer with a valid access token to unlock their account provided that they successfully pass the prompted Bot Protection challenges. The Block or Suspend block types are not applicable for this API. For additional details see our Auth Security Configuration documentation.You are only required to pass the Post Parameters that correspond to the prompted challenges.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param unlock_profile_model - Payload containing Unlock Profile API
    #
    # @return Response containing Definition of Complete Validation data
    # 5.15
    def unlock_account_by_token(access_token, unlock_profile_model)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if unlock_profile_model.blank?
        raise LoginRadius::Error.new, get_validation_message('unlock_profile_model')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/account/unlock'
      put_request(resource_path, query_parameters, unlock_profile_model)
    end

    # This API is used to get a user's profile using the clientGuid parameter if no callback feature enabled
    #
    # @param client_guid - ClientGuid
    # @param email_template - EmailTemplate
    # @param fields - Fields
    # @param verification_url - VerificationUrl
    # @param welcome_email_template - WelcomeEmailTemplate
    #
    # @return Response containing User Profile Data and access token
    # 5.16
    def get_profile_by_ping(client_guid, email_template = '', fields = '', verification_url = '', welcome_email_template = '')
      if is_null_or_white_space(client_guid)
        raise LoginRadius::Error.new, get_validation_message('client_guid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['clientGuid'] = client_guid
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/account/ping'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to check the email exists or not on your site.
    #
    # @param email - Email of the user
    #
    # @return Response containing Definition Complete ExistResponse data
    # 8.1
    def check_email_availability(email)
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['email'] = email

      resource_path = 'identity/v2/auth/email'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to verify the email of user. Note: This API will only return the full profile if you have 'Enable auto login after email verification' set in your LoginRadius Admin Console's Email Workflow settings under 'Verification Email'.
    #
    # @param verification_token - Verification token received in the email
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param url - Mention URL to log the main URL(Domain name) in Database.
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation, UserProfile data and Access Token
    # 8.2
    def verify_email(verification_token, fields = '', url = '', welcome_email_template = '')
      if is_null_or_white_space(verification_token)
        raise LoginRadius::Error.new, get_validation_message('verification_token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['verificationToken'] = verification_token
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(url)
        query_parameters['url'] = url
      end
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/email'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to verify the email of user when the OTP Email verification flow is enabled, please note that you must contact LoginRadius to have this feature enabled.
    #
    # @param email_verification_by_otp_model - Model Class containing Definition for EmailVerificationByOtpModel API
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param url - Mention URL to log the main URL(Domain name) in Database.
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation, UserProfile data and Access Token
    # 8.3
    def verify_email_by_otp(email_verification_by_otp_model, fields = '', url = '', welcome_email_template = '')
      if email_verification_by_otp_model.blank?
        raise LoginRadius::Error.new, get_validation_message('email_verification_by_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(url)
        query_parameters['url'] = url
      end
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/email'
      put_request(resource_path, query_parameters, email_verification_by_otp_model)
    end

    # This API is used to add additional emails to a user's account.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param email - user's email
    # @param type - String to identify the type of parameter
    # @param email_template - Email template name
    # @param verification_url - Email verification url
    #
    # @return Response containing Definition of Complete Validation data
    # 8.5
    def add_email(access_token, email, type, email_template = '', verification_url = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end
      if is_null_or_white_space(type)
        raise LoginRadius::Error.new, get_validation_message('type')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      body_parameters = {}
      body_parameters['email'] = email
      body_parameters['type'] = type

      resource_path = 'identity/v2/auth/email'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to remove additional emails from a user's account.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param email - user's email
    #
    # @return Response containing Definition of Delete Request
    # 8.6
    def remove_email(access_token, email)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['email'] = email

      resource_path = 'identity/v2/auth/email'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API retrieves a copy of the user data based on the Email
    #
    # @param email_authentication_model - Model Class containing Definition of payload for Email Authentication API
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param verification_url - Email verification url
    #
    # @return Response containing User Profile Data and access token
    # 9.2.1
    def login_by_email(email_authentication_model, email_template = '', fields = '', login_url = '', verification_url = '')
      if email_authentication_model.blank?
        raise LoginRadius::Error.new, get_validation_message('email_authentication_model')
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
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/login'
      post_request(resource_path, query_parameters, email_authentication_model)
    end

    # This API retrieves a copy of the user data based on the Username
    #
    # @param user_name_authentication_model - Model Class containing Definition of payload for Username Authentication API
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param verification_url - Email verification url
    #
    # @return Response containing User Profile Data and access token
    # 9.2.2
    def login_by_user_name(user_name_authentication_model, email_template = '', fields = '', login_url = '', verification_url = '')
      if user_name_authentication_model.blank?
        raise LoginRadius::Error.new, get_validation_message('user_name_authentication_model')
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
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/login'
      post_request(resource_path, query_parameters, user_name_authentication_model)
    end

    # This API is used to send the reset password url to a specified account. Note: If you have the UserName workflow enabled, you may replace the 'email' parameter with 'username'
    #
    # @param email - user's email
    # @param reset_password_url - Url to which user should get re-directed to for resetting the password
    # @param email_template - Email template name
    #
    # @return Response containing Definition of Complete Validation data
    # 10.1
    def forgot_password(email, reset_password_url, email_template = '')
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end
      if is_null_or_white_space(reset_password_url)
        raise LoginRadius::Error.new, get_validation_message('reset_password_url')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['resetPasswordUrl'] = reset_password_url
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end

      body_parameters = {}
      body_parameters['email'] = email

      resource_path = 'identity/v2/auth/password'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to reset password for the specified account by security question
    #
    # @param reset_password_by_security_answer_and_email_model - Model Class containing Definition of payload for ResetPasswordBySecurityAnswerAndEmail API
    #
    # @return Response containing Definition of Validation data and access token
    # 10.3.1
    def reset_password_by_security_answer_and_email(reset_password_by_security_answer_and_email_model)
      if reset_password_by_security_answer_and_email_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reset_password_by_security_answer_and_email_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/securityanswer'
      put_request(resource_path, query_parameters, reset_password_by_security_answer_and_email_model)
    end

    # This API is used to reset password for the specified account by security question
    #
    # @param reset_password_by_security_answer_and_phone_model - Model Class containing Definition of payload for ResetPasswordBySecurityAnswerAndPhone API
    #
    # @return Response containing Definition of Validation data and access token
    # 10.3.2
    def reset_password_by_security_answer_and_phone(reset_password_by_security_answer_and_phone_model)
      if reset_password_by_security_answer_and_phone_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reset_password_by_security_answer_and_phone_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/securityanswer'
      put_request(resource_path, query_parameters, reset_password_by_security_answer_and_phone_model)
    end

    # This API is used to reset password for the specified account by security question
    #
    # @param reset_password_by_security_answer_and_user_name_model - Model Class containing Definition of payload for ResetPasswordBySecurityAnswerAndUserName API
    #
    # @return Response containing Definition of Validation data and access token
    # 10.3.3
    def reset_password_by_security_answer_and_user_name(reset_password_by_security_answer_and_user_name_model)
      if reset_password_by_security_answer_and_user_name_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reset_password_by_security_answer_and_user_name_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/securityanswer'
      put_request(resource_path, query_parameters, reset_password_by_security_answer_and_user_name_model)
    end

    # This API is used to set a new password for the specified account.
    #
    # @param reset_password_by_reset_token_model - Model Class containing Definition of payload for ResetToken API
    #
    # @return Response containing Definition of Validation data and access token
    # 10.7.1
    def reset_password_by_reset_token(reset_password_by_reset_token_model)
      if reset_password_by_reset_token_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reset_password_by_reset_token_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/reset'
      put_request(resource_path, query_parameters, reset_password_by_reset_token_model)
    end

    # This API is used to set a new password for the specified account.
    #
    # @param reset_password_by_email_and_otp_model - Model Class containing Definition of payload for ResetPasswordByEmailAndOtp API
    #
    # @return Response containing Definition of Validation data and access token
    # 10.7.2
    def reset_password_by_email_otp(reset_password_by_email_and_otp_model)
      if reset_password_by_email_and_otp_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reset_password_by_email_and_otp_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/reset'
      put_request(resource_path, query_parameters, reset_password_by_email_and_otp_model)
    end

    # This API is used to set a new password for the specified account if you are using the username as the unique identifier in your workflow
    #
    # @param reset_password_by_user_name_model - Model Class containing Definition of payload for ResetPasswordByUserName API
    #
    # @return Response containing Definition of Validation data and access token
    # 10.7.3
    def reset_password_by_otp_and_user_name(reset_password_by_user_name_model)
      if reset_password_by_user_name_model.blank?
        raise LoginRadius::Error.new, get_validation_message('reset_password_by_user_name_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/password/reset'
      put_request(resource_path, query_parameters, reset_password_by_user_name_model)
    end

    # This API is used to change the accounts password based on the previous password
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param new_password - New password
    # @param old_password - User's current password
    #
    # @return Response containing Definition of Complete Validation data
    # 10.8
    def change_password(access_token, new_password, old_password)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(new_password)
        raise LoginRadius::Error.new, get_validation_message('new_password')
      end
      if is_null_or_white_space(old_password)
        raise LoginRadius::Error.new, get_validation_message('old_password')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['newPassword'] = new_password
      body_parameters['oldPassword'] = old_password

      resource_path = 'identity/v2/auth/password/change'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to unlink up a social provider account with the specified account based on the access token and the social providers user access token. The unlinked account will automatically get removed from your database.
    #
    # @param access_token - Access_Token
    # @param provider - Name of the provider
    # @param provider_id - Unique ID of the linked account
    #
    # @return Response containing Definition of Delete Request
    # 12.2
    def unlink_social_identities(access_token, provider, provider_id)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(provider)
        raise LoginRadius::Error.new, get_validation_message('provider')
      end
      if is_null_or_white_space(provider_id)
        raise LoginRadius::Error.new, get_validation_message('provider_id')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['provider'] = provider
      body_parameters['providerId'] = provider_id

      resource_path = 'identity/v2/auth/socialidentity'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to link up a social provider account with an existing LoginRadius account on the basis of access token and the social providers user access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param candidate_token - Access token of the account to be linked
    #
    # @return Response containing Definition of Complete Validation data
    # 12.4
    def link_social_identities(access_token, candidate_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(candidate_token)
        raise LoginRadius::Error.new, get_validation_message('candidate_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['candidateToken'] = candidate_token

      resource_path = 'identity/v2/auth/socialidentity'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to link up a social provider account with an existing LoginRadius account on the basis of ping and the social providers user access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param client_guid - Unique ID generated by client
    #
    # @return Response containing Definition of Complete Validation data
    # 12.5
    def link_social_identities_by_ping(access_token, client_guid)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(client_guid)
        raise LoginRadius::Error.new, get_validation_message('client_guid')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['clientGuid'] = client_guid

      resource_path = 'identity/v2/auth/socialidentity'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to set or change UserName by access token.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param username - Username of the user
    #
    # @return Response containing Definition of Complete Validation data
    # 13.1
    def set_or_change_user_name(access_token, username)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end
      if is_null_or_white_space(username)
        raise LoginRadius::Error.new, get_validation_message('username')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      body_parameters = {}
      body_parameters['username'] = username

      resource_path = 'identity/v2/auth/username'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to check the UserName exists or not on your site.
    #
    # @param username - UserName of the user
    #
    # @return Response containing Definition Complete ExistResponse data
    # 13.2
    def check_user_name_availability(username)
      if is_null_or_white_space(username)
        raise LoginRadius::Error.new, get_validation_message('username')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['username'] = username

      resource_path = 'identity/v2/auth/username'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to update the privacy policy stored in the user's profile by providing the access token of the user accepting the privacy policy
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 15.1
    def accept_privacy_policy(access_token, fields = '')
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/auth/privacypolicy/accept'
      get_request(resource_path, query_parameters, {})
    end

    # This API will return all the accepted privacy policies for the user by providing the access token of that user.
    #
    # @param access_token - Uniquely generated identifier key by LoginRadius that is activated after successful authentication.
    #
    # @return Complete Policy History data
    # 15.2
    def get_privacy_policy_history_by_access_token(access_token)
      if is_null_or_white_space(access_token)
        raise LoginRadius::Error.new, get_validation_message('access_token')
      end

      query_parameters = {}
      query_parameters['access_token'] = access_token
      query_parameters['apiKey'] = @api_key

      resource_path = 'identity/v2/auth/privacypolicy/history'
      get_request(resource_path, query_parameters, {})
    end

    # This API creates a user in the database as well as sends a verification email to the user.
    #
    # @param auth_user_registration_model - Model Class containing Definition of payload for Auth User Registration API
    # @param sott - LoginRadius Secured One Time Token
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param options - PreventVerificationEmail (Specifying this value prevents the verification email from being sent. Only applicable if you have the optional email verification flow)
    # @param verification_url - Email verification url
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation, UserProfile data and Access Token
    # 17.1.1
    def user_registration_by_email(auth_user_registration_model, sott, email_template = '', fields = '', options = '', verification_url = '', welcome_email_template = '')
      if auth_user_registration_model.blank?
        raise LoginRadius::Error.new, get_validation_message('auth_user_registration_model')
      end
      if is_null_or_white_space(sott)
        raise LoginRadius::Error.new, get_validation_message('sott')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['sott'] = sott
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(options)
        query_parameters['options'] = options
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/register'
      post_request(resource_path, query_parameters, auth_user_registration_model)
    end

    # This API creates a user in the database as well as sends a verification email to the user.
    #
    # @param auth_user_registration_model_with_captcha - Model Class containing Definition of payload for Auth User Registration by Recaptcha API
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param options - PreventVerificationEmail (Specifying this value prevents the verification email from being sent. Only applicable if you have the optional email verification flow)
    # @param sms_template - SMS Template name
    # @param verification_url - Email verification url
    # @param welcome_email_template - Name of the welcome email template
    #
    # @return Response containing Definition of Complete Validation, UserProfile data and Access Token
    # 17.2
    def user_registration_by_captcha(auth_user_registration_model_with_captcha, email_template = '', fields = '', options = '', sms_template = '', verification_url = '', welcome_email_template = '')
      if auth_user_registration_model_with_captcha.blank?
        raise LoginRadius::Error.new, get_validation_message('auth_user_registration_model_with_captcha')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(fields)
        query_parameters['fields'] = fields
      end
      unless is_null_or_white_space(options)
        query_parameters['options'] = options
      end
      unless is_null_or_white_space(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end
      unless is_null_or_white_space(welcome_email_template)
        query_parameters['welcomeEmailTemplate'] = welcome_email_template
      end

      resource_path = 'identity/v2/auth/register/captcha'
      post_request(resource_path, query_parameters, auth_user_registration_model_with_captcha)
    end

    # This API resends the verification email to the user.
    #
    # @param email - user's email
    # @param email_template - Email template name
    # @param verification_url - Email verification url
    #
    # @return Response containing Definition of Complete Validation data
    # 17.3
    def auth_resend_email_verification(email, email_template = '', verification_url = '')
      if is_null_or_white_space(email)
        raise LoginRadius::Error.new, get_validation_message('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless is_null_or_white_space(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless is_null_or_white_space(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      body_parameters = {}
      body_parameters['email'] = email

      resource_path = 'identity/v2/auth/register'
      put_request(resource_path, query_parameters, body_parameters)
    end
  end
end
