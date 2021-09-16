# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # AccountApi module
  class AccountApi
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

    # This API is used to retrieve all of the accepted Policies by the user, associated with their UID.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Complete Policy History data
    # 15.1.1
    def get_privacy_policy_history_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/privacypolicy/history'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to create an account in Cloud Storage. This API bypass the normal email verification process and manually creates the user. <br><br>In order to use this API, you need to format a JSON request body with all of the mandatory fields
    #
    # @param account_create_model - Model Class containing Definition of payload for Account Create API
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.1
    def create_account(account_create_model, fields = '')
      if account_create_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('account_create_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account'
      post_request(resource_path, query_parameters, account_create_model)
    end

    # This API is used to retrieve all of the profile data, associated with the specified account by email in Cloud Storage.
    #
    # @param email - Email of the user
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.2
    def get_account_profile_by_email(email, fields = '')
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['email'] = email
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve all of the profile data associated with the specified account by user name in Cloud Storage.
    #
    # @param user_name - UserName of the user
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.3
    def get_account_profile_by_user_name(user_name, fields = '')
      if isNullOrWhiteSpace(user_name)
        raise LoginRadius::Error.new, getValidationMessage('user_name')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['userName'] = user_name
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve all of the profile data, associated with the account by phone number in Cloud Storage.
    #
    # @param phone - The Registered Phone Number
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.4
    def get_account_profile_by_phone(phone, fields = '')
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['phone'] = phone
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve all of the profile data, associated with the account by uid in Cloud Storage.
    #
    # @param uid - UID, the unified identifier for each user account
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.5
    def get_account_profile_by_uid(uid, fields = '')
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account/' + uid
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to update the information of existing accounts in your Cloud Storage. See our Advanced API Usage section <a href='https://www.loginradius.com/docs/api/v2/customer-identity-api/advanced-api-usage/'>Here</a> for more capabilities.
    #
    # @param account_user_profile_update_model - Model Class containing Definition of payload for Account Update API
    # @param uid - UID, the unified identifier for each user account
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param null_support - Boolean, pass true if you wish to update any user profile field with a NULL value, You can get the details
    #
    # @return Response containing Definition for Complete profile data
    # 18.15
    def update_account_by_uid(account_user_profile_update_model, uid, fields = '', null_support = false)
      if account_user_profile_update_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('account_user_profile_update_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless null_support == false
        query_parameters['nullSupport'] = null_support
      end

      resource_path = 'identity/v2/manage/account/' + uid
      put_request(resource_path, query_parameters, account_user_profile_update_model)
    end

    # This API is used to update the PhoneId by using the Uid's. Admin can update the PhoneId's for both the verified and unverified profiles. It will directly replace the PhoneId and bypass the OTP verification process.
    #
    # @param phone - Phone number
    # @param uid - UID, the unified identifier for each user account
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.16
    def update_phone_id_by_uid(phone, uid, fields = '')
      if isNullOrWhiteSpace(phone)
        raise LoginRadius::Error.new, getValidationMessage('phone')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      body_parameters = {}
      body_parameters['phone'] = phone

      resource_path = 'identity/v2/manage/account/' + uid + '/phoneid'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API use to retrive the hashed password of a specified account in Cloud Storage.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition for Complete PasswordHash data
    # 18.17
    def get_account_password_hash_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/password'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to set the password of an account in Cloud Storage.
    #
    # @param password - New password
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition for Complete PasswordHash data
    # 18.18
    def set_account_password_by_uid(password, uid)
      if isNullOrWhiteSpace(password)
        raise LoginRadius::Error.new, getValidationMessage('password')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      body_parameters = {}
      body_parameters['password'] = password

      resource_path = 'identity/v2/manage/account/' + uid + '/password'
      put_request(resource_path, query_parameters, body_parameters)
    end

    # This API deletes the Users account and allows them to re-register for a new account.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.19
    def delete_account_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to invalidate the Email Verification status on an account.
    #
    # @param uid - UID, the unified identifier for each user account
    # @param email_template - Email template name
    # @param verification_url - Email verification url
    #
    # @return Response containing Definition of Complete Validation data
    # 18.20
    def invalidate_account_email_verification(uid, email_template = '', verification_url = '')
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/manage/account/' + uid + '/invalidateemail'
      put_request(resource_path, query_parameters, {})
    end

    # This API Returns a Forgot Password Token it can also be used to send a Forgot Password email to the customer. Note: If you have the UserName workflow enabled, you may replace the 'email' parameter with 'username' in the body.
    #
    # @param email - user's email
    # @param email_template - Email template name
    # @param reset_password_url - Url to which user should get re-directed to for resetting the password
    # @param send_email - If set to true, the API will also send a Forgot Password email to the customer, bypassing any Bot Protection challenges that they are faced with.
    #
    # @return Response containing Definition of Complete Forgot Password data
    # 18.22
    def get_forgot_password_token(email, email_template = '', reset_password_url = '', send_email = false)
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(reset_password_url)
        query_parameters['resetPasswordUrl'] = reset_password_url
      end
      unless send_email == false
        query_parameters['sendEmail'] = send_email
      end

      body_parameters = {}
      body_parameters['email'] = email

      resource_path = 'identity/v2/manage/account/forgot/token'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # This API Returns an Email Verification token.
    #
    # @param email - user's email
    #
    # @return Response containing Definition of Complete Verification data
    # 18.23
    def get_email_verification_token(email)
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      body_parameters = {}
      body_parameters['email'] = email

      resource_path = 'identity/v2/manage/account/verify/token'
      post_request(resource_path, query_parameters, body_parameters)
    end

    # The API is used to get LoginRadius access token based on UID.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Token data
    # 18.24
    def get_access_token_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      resource_path = 'identity/v2/manage/account/access_token'
      get_request(resource_path, query_parameters, {})
    end

    # This API Allows you to reset the phone no verification of an end user’s account.
    #
    # @param uid - UID, the unified identifier for each user account
    # @param sms_template - SMS Template name
    #
    # @return Response containing Definition of Complete Validation data
    # 18.27
    def reset_phone_id_verification_by_uid(uid, sms_template = '')
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end

      resource_path = 'identity/v2/manage/account/' + uid + '/invalidatephone'
      put_request(resource_path, query_parameters, {})
    end

    # This API is used to add/upsert another emails in account profile by different-different email types. If the email type is same then it will simply update the existing email, otherwise it will add a new email in Email array.
    #
    # @param upsert_email_model - Model Class containing Definition of payload for UpsertEmail Property
    # @param uid - UID, the unified identifier for each user account
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.29
    def upsert_email(upsert_email_model, uid, fields = '')
      if upsert_email_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('upsert_email_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account/' + uid + '/email'
      put_request(resource_path, query_parameters, upsert_email_model)
    end

    # Use this API to Remove emails from a user Account
    #
    # @param email - user's email
    # @param uid - UID, the unified identifier for each user account
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Response containing Definition for Complete profile data
    # 18.30
    def remove_email(email, uid, fields = '')
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      body_parameters = {}
      body_parameters['email'] = email

      resource_path = 'identity/v2/manage/account/' + uid + '/email'
      delete_request(resource_path, query_parameters, body_parameters)
    end

    # This API is used to refresh an access token via it's associated refresh token.
    #
    # @param refresh__token - LoginRadius refresh token
    #
    # @return Response containing Definition of Complete Token data
    # 18.31
    def refresh_access_token_by_refresh_token(refresh__token)
      if isNullOrWhiteSpace(refresh__token)
        raise LoginRadius::Error.new, getValidationMessage('refresh__token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['refresh_Token'] = refresh__token

      resource_path = 'identity/v2/manage/account/access_token/refresh'
      get_request(resource_path, query_parameters, {})
    end

    # The Revoke Refresh Access Token API is used to revoke a refresh token or the Provider Access Token, revoking an existing refresh token will invalidate the refresh token but the associated access token will work until the expiry.
    #
    # @param refresh__token - LoginRadius refresh token
    #
    # @return Response containing Definition of Delete Request
    # 18.32
    def revoke_refresh_token(refresh__token)
      if isNullOrWhiteSpace(refresh__token)
        raise LoginRadius::Error.new, getValidationMessage('refresh__token')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['refresh_Token'] = refresh__token

      resource_path = 'identity/v2/manage/account/access_token/refresh/revoke'
      get_request(resource_path, query_parameters, {})
    end

    # Note: This is intended for specific workflows where an email may be associated to multiple UIDs. This API is used to retrieve all of the identities (UID and Profiles), associated with a specified email in Cloud Storage.
    #
    # @param email - Email of the user
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    #
    # @return Complete user Identity data
    # 18.35
    def get_account_identities_by_email(email, fields = '')
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['email'] = email
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end

      resource_path = 'identity/v2/manage/account/identities'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to delete all user profiles associated with an Email.
    #
    # @param email - Email of the user
    #
    # @return Response containing Definition of Delete Request
    # 18.36
    def account_delete_by_email(email)
      if isNullOrWhiteSpace(email)
        raise LoginRadius::Error.new, getValidationMessage('email')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['email'] = email

      resource_path = 'identity/v2/manage/account'
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to update a user's Uid. It will update all profiles, custom objects and consent management logs associated with the Uid.
    #
    # @param update_uid_model - Payload containing Update UID
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Validation data
    # 18.41
    def account_update_uid(update_uid_model, uid)
      if update_uid_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('update_uid_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      query_parameters['uid'] = uid

      resource_path = 'identity/v2/manage/account/uid'
      put_request(resource_path, query_parameters, update_uid_model)
    end
  end
end
