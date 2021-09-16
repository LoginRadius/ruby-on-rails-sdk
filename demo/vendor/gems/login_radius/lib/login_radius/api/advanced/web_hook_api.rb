# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # WebHookApi module
  class WebHookApi
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

    # This API is used to fatch all the subscribed URLs, for particular event
    #
    # @param event - Allowed events: Login, Register, UpdateProfile, ResetPassword, ChangePassword, emailVerification, AddEmail, RemoveEmail, BlockAccount, DeleteAccount, SetUsername, AssignRoles, UnassignRoles, SetPassword, LinkAccount, UnlinkAccount, UpdatePhoneId, VerifyPhoneNumber, CreateCustomObject, UpdateCustomobject, DeleteCustomObject
    #
    # @return Response Containing List of Webhhook Data
    # 40.1
    def get_web_hook_subscribed_u_r_ls(event)
      if isNullOrWhiteSpace(event)
        raise LoginRadius::Error.new, getValidationMessage('event')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret
      query_parameters['event'] = event

      resource_path = 'api/v2/webhook'
      get_request(resource_path, query_parameters, {})
    end

    # API can be used to configure a WebHook on your LoginRadius site. Webhooks also work on subscribe and notification model, subscribe your hook and get a notification. Equivalent to RESThook but these provide security on basis of signature and RESThook work on unique URL. Following are the events that are allowed by LoginRadius to trigger a WebHook service call.
    #
    # @param web_hook_subscribe_model - Model Class containing Definition of payload for Webhook Subscribe API
    #
    # @return Response containing Definition of Complete Validation data
    # 40.2
    def web_hook_subscribe(web_hook_subscribe_model)
      if web_hook_subscribe_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('web_hook_subscribe_model')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'api/v2/webhook'
      post_request(resource_path, query_parameters, web_hook_subscribe_model)
    end

    # API can be used to test a subscribed WebHook.
    #
    #
    # @return Response containing Definition of Complete Validation data
    # 40.3
    def webhook_test()

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'api/v2/webhook/test'
      get_request(resource_path, query_parameters, {})
    end

    # API can be used to unsubscribe a WebHook configured on your LoginRadius site.
    #
    # @param web_hook_subscribe_model - Model Class containing Definition of payload for Webhook Subscribe API
    #
    # @return Response containing Definition of Delete Request
    # 40.4
    def web_hook_unsubscribe(web_hook_subscribe_model)
      if web_hook_subscribe_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('web_hook_subscribe_model')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'api/v2/webhook'
      delete_request(resource_path, query_parameters, web_hook_subscribe_model)
    end
  end
end
