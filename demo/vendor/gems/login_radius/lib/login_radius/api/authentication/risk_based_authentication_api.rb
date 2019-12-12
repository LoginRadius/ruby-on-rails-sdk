# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # RiskBasedAuthenticationApi module
  class RiskBasedAuthenticationApi
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

    # This API retrieves a copy of the user data based on the Email
    #
    # @param email_authentication_model - Model Class containing Definition of payload for Email Authentication API
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param password_delegation - Password Delegation Allows you to use a third-party service to store your passwords rather than LoginRadius Cloud storage.
    # @param password_delegation_app - RiskBased Authentication Password Delegation App
    # @param rba_browser_email_template - Risk Based Authentication Browser EmailTemplate
    # @param rba_browser_sms_template - Risk Based Authentication Browser Sms Template
    # @param rba_city_email_template - Risk Based Authentication City Email Template
    # @param rba_city_sms_template - Risk Based Authentication City SmsTemplate
    # @param rba_country_email_template - Risk Based Authentication Country EmailTemplate
    # @param rba_country_sms_template - Risk Based Authentication Country SmsTemplate
    # @param rba_ip_email_template - Risk Based Authentication Ip EmailTemplate
    # @param rba_ip_sms_template - Risk Based Authentication Ip SmsTemplate
    # @param rba_oneclick_email_template - Risk Based Authentication Oneclick EmailTemplate
    # @param rba_otp_sms_template - Risk Based Authentication Oneclick EmailTemplate
    # @param sms_template - SMS Template name
    # @param verification_url - Email verification url
    #
    # @return Response containing User Profile Data and access token
    # 9.2.4
    def rba_login_by_email(email_authentication_model, email_template = '', fields = '', login_url = '', password_delegation = false, password_delegation_app = '', rba_browser_email_template = '', rba_browser_sms_template = '', rba_city_email_template = '', rba_city_sms_template = '', rba_country_email_template = '', rba_country_sms_template = '', rba_ip_email_template = '', rba_ip_sms_template = '', rba_oneclick_email_template = '', rba_otp_sms_template = '', sms_template = '', verification_url = '')
      if email_authentication_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('email_authentication_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless password_delegation == false
        query_parameters['passwordDelegation'] = password_delegation
      end
      unless isNullOrWhiteSpace(password_delegation_app)
        query_parameters['passwordDelegationApp'] = password_delegation_app
      end
      unless isNullOrWhiteSpace(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless isNullOrWhiteSpace(rba_browser_sms_template)
        query_parameters['rbaBrowserSmsTemplate'] = rba_browser_sms_template
      end
      unless isNullOrWhiteSpace(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless isNullOrWhiteSpace(rba_city_sms_template)
        query_parameters['rbaCitySmsTemplate'] = rba_city_sms_template
      end
      unless isNullOrWhiteSpace(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless isNullOrWhiteSpace(rba_country_sms_template)
        query_parameters['rbaCountrySmsTemplate'] = rba_country_sms_template
      end
      unless isNullOrWhiteSpace(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end
      unless isNullOrWhiteSpace(rba_ip_sms_template)
        query_parameters['rbaIpSmsTemplate'] = rba_ip_sms_template
      end
      unless isNullOrWhiteSpace(rba_oneclick_email_template)
        query_parameters['rbaOneclickEmailTemplate'] = rba_oneclick_email_template
      end
      unless isNullOrWhiteSpace(rba_otp_sms_template)
        query_parameters['rbaOTPSmsTemplate'] = rba_otp_sms_template
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless isNullOrWhiteSpace(verification_url)
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
    # @param password_delegation - Password Delegation Allows you to use a third-party service to store your passwords rather than LoginRadius Cloud storage.
    # @param password_delegation_app - RiskBased Authentication Password Delegation App
    # @param rba_browser_email_template - Risk Based Authentication Browser EmailTemplate
    # @param rba_browser_sms_template - Risk Based Authentication Browser Sms Template
    # @param rba_city_email_template - Risk Based Authentication City Email Template
    # @param rba_city_sms_template - Risk Based Authentication City SmsTemplate
    # @param rba_country_email_template - Risk Based Authentication Country EmailTemplate
    # @param rba_country_sms_template - Risk Based Authentication Country SmsTemplate
    # @param rba_ip_email_template - Risk Based Authentication Ip EmailTemplate
    # @param rba_ip_sms_template - Risk Based Authentication Ip SmsTemplate
    # @param rba_oneclick_email_template - Risk Based Authentication Oneclick EmailTemplate
    # @param rba_otp_sms_template - Risk Based Authentication OTPSmsTemplate
    # @param sms_template - SMS Template name
    # @param verification_url - Email verification url
    #
    # @return Response containing User Profile Data and access token
    # 9.2.5
    def rba_login_by_user_name(user_name_authentication_model, email_template = '', fields = '', login_url = '', password_delegation = false, password_delegation_app = '', rba_browser_email_template = '', rba_browser_sms_template = '', rba_city_email_template = '', rba_city_sms_template = '', rba_country_email_template = '', rba_country_sms_template = '', rba_ip_email_template = '', rba_ip_sms_template = '', rba_oneclick_email_template = '', rba_otp_sms_template = '', sms_template = '', verification_url = '')
      if user_name_authentication_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('user_name_authentication_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless password_delegation == false
        query_parameters['passwordDelegation'] = password_delegation
      end
      unless isNullOrWhiteSpace(password_delegation_app)
        query_parameters['passwordDelegationApp'] = password_delegation_app
      end
      unless isNullOrWhiteSpace(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless isNullOrWhiteSpace(rba_browser_sms_template)
        query_parameters['rbaBrowserSmsTemplate'] = rba_browser_sms_template
      end
      unless isNullOrWhiteSpace(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless isNullOrWhiteSpace(rba_city_sms_template)
        query_parameters['rbaCitySmsTemplate'] = rba_city_sms_template
      end
      unless isNullOrWhiteSpace(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless isNullOrWhiteSpace(rba_country_sms_template)
        query_parameters['rbaCountrySmsTemplate'] = rba_country_sms_template
      end
      unless isNullOrWhiteSpace(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end
      unless isNullOrWhiteSpace(rba_ip_sms_template)
        query_parameters['rbaIpSmsTemplate'] = rba_ip_sms_template
      end
      unless isNullOrWhiteSpace(rba_oneclick_email_template)
        query_parameters['rbaOneclickEmailTemplate'] = rba_oneclick_email_template
      end
      unless isNullOrWhiteSpace(rba_otp_sms_template)
        query_parameters['rbaOTPSmsTemplate'] = rba_otp_sms_template
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless isNullOrWhiteSpace(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/login'
      post_request(resource_path, query_parameters, user_name_authentication_model)
    end

    # This API retrieves a copy of the user data based on the Phone
    #
    # @param phone_authentication_model - Model Class containing Definition of payload for PhoneAuthenticationModel API
    # @param email_template - Email template name
    # @param fields - The fields parameter filters the API response so that the response only includes a specific set of fields
    # @param login_url - Url where the user is logging from
    # @param password_delegation - Password Delegation Allows you to use a third-party service to store your passwords rather than LoginRadius Cloud storage.
    # @param password_delegation_app - RiskBased Authentication Password Delegation App
    # @param rba_browser_email_template - Risk Based Authentication Browser EmailTemplate
    # @param rba_browser_sms_template - Risk Based Authentication Browser Sms Template
    # @param rba_city_email_template - Risk Based Authentication City Email Template
    # @param rba_city_sms_template - Risk Based Authentication City SmsTemplate
    # @param rba_country_email_template - Risk Based Authentication Country EmailTemplate
    # @param rba_country_sms_template - Risk Based Authentication Country SmsTemplate
    # @param rba_ip_email_template - Risk Based Authentication Ip EmailTemplate
    # @param rba_ip_sms_template - Risk Based Authentication Ip SmsTemplate
    # @param rba_oneclick_email_template - Risk Based Authentication Oneclick EmailTemplate
    # @param rba_otp_sms_template - Risk Based Authentication OTPSmsTemplate
    # @param sms_template - SMS Template name
    # @param verification_url - Email verification url
    #
    # @return Response containing User Profile Data and access token
    # 9.2.6
    def rba_login_by_phone(phone_authentication_model, email_template = '', fields = '', login_url = '', password_delegation = false, password_delegation_app = '', rba_browser_email_template = '', rba_browser_sms_template = '', rba_city_email_template = '', rba_city_sms_template = '', rba_country_email_template = '', rba_country_sms_template = '', rba_ip_email_template = '', rba_ip_sms_template = '', rba_oneclick_email_template = '', rba_otp_sms_template = '', sms_template = '', verification_url = '')
      if phone_authentication_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('phone_authentication_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless isNullOrWhiteSpace(email_template)
        query_parameters['emailTemplate'] = email_template
      end
      unless isNullOrWhiteSpace(fields)
        query_parameters['fields'] = fields
      end
      unless isNullOrWhiteSpace(login_url)
        query_parameters['loginUrl'] = login_url
      end
      unless password_delegation == false
        query_parameters['passwordDelegation'] = password_delegation
      end
      unless isNullOrWhiteSpace(password_delegation_app)
        query_parameters['passwordDelegationApp'] = password_delegation_app
      end
      unless isNullOrWhiteSpace(rba_browser_email_template)
        query_parameters['rbaBrowserEmailTemplate'] = rba_browser_email_template
      end
      unless isNullOrWhiteSpace(rba_browser_sms_template)
        query_parameters['rbaBrowserSmsTemplate'] = rba_browser_sms_template
      end
      unless isNullOrWhiteSpace(rba_city_email_template)
        query_parameters['rbaCityEmailTemplate'] = rba_city_email_template
      end
      unless isNullOrWhiteSpace(rba_city_sms_template)
        query_parameters['rbaCitySmsTemplate'] = rba_city_sms_template
      end
      unless isNullOrWhiteSpace(rba_country_email_template)
        query_parameters['rbaCountryEmailTemplate'] = rba_country_email_template
      end
      unless isNullOrWhiteSpace(rba_country_sms_template)
        query_parameters['rbaCountrySmsTemplate'] = rba_country_sms_template
      end
      unless isNullOrWhiteSpace(rba_ip_email_template)
        query_parameters['rbaIpEmailTemplate'] = rba_ip_email_template
      end
      unless isNullOrWhiteSpace(rba_ip_sms_template)
        query_parameters['rbaIpSmsTemplate'] = rba_ip_sms_template
      end
      unless isNullOrWhiteSpace(rba_oneclick_email_template)
        query_parameters['rbaOneclickEmailTemplate'] = rba_oneclick_email_template
      end
      unless isNullOrWhiteSpace(rba_otp_sms_template)
        query_parameters['rbaOTPSmsTemplate'] = rba_otp_sms_template
      end
      unless isNullOrWhiteSpace(sms_template)
        query_parameters['smsTemplate'] = sms_template
      end
      unless isNullOrWhiteSpace(verification_url)
        query_parameters['verificationUrl'] = verification_url
      end

      resource_path = 'identity/v2/auth/login'
      post_request(resource_path, query_parameters, phone_authentication_model)
    end
  end
end
