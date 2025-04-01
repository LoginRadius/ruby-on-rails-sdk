# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2025 LoginRadius Inc. All rights reserved.
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

    # This API is used to get details of a webhook subscription by Id
    #
    # @param hook_id - Unique ID of the webhook
    #
    # @return Response containing Definition for Complete WebHook data
    # 40.1
    def get_webhook_subscription_detail(hook_id)
      if isNullOrWhiteSpace(hook_id)
        raise LoginRadius::Error.new, getValidationMessage('hook_id')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'v2/manage/webhooks/' + hook_id
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to create a new webhook subscription on your LoginRadius site.
    #
    # @param web_hook_subscribe_model - Model Class containing Definition of payload for Webhook Subscribe API
    #
    # @return Response containing Definition for Complete WebHook data
    # 40.2
    def create_webhook_subscription(web_hook_subscribe_model)
      if web_hook_subscribe_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('web_hook_subscribe_model')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'v2/manage/webhooks'
      post_request(resource_path, query_parameters, web_hook_subscribe_model)
    end

    # This API is used to delete webhook subscription
    #
    # @param hook_id - Unique ID of the webhook
    #
    # @return Response containing Definition of Delete Request
    # 40.3
    def delete_webhook_subscription(hook_id)
      if isNullOrWhiteSpace(hook_id)
        raise LoginRadius::Error.new, getValidationMessage('hook_id')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'v2/manage/webhooks/' + hook_id
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to update a webhook subscription
    #
    # @param hook_id - Unique ID of the webhook
    # @param web_hook_subscription_update_model - Model Class containing Definition for WebHookSubscriptionUpdateModel Property
    #
    # @return Response containing Definition for Complete WebHook data
    # 40.4
    def update_webhook_subscription(hook_id, web_hook_subscription_update_model)
      if isNullOrWhiteSpace(hook_id)
        raise LoginRadius::Error.new, getValidationMessage('hook_id')
      end
      if web_hook_subscription_update_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('web_hook_subscription_update_model')
      end

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'v2/manage/webhooks/' + hook_id
      put_request(resource_path, query_parameters, web_hook_subscription_update_model)
    end

    # This API is used to get the list of all the webhooks
    #
    #
    # @return Response Containing List of Webhhook Data
    # 40.5
    def list_all_webhooks()

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'v2/manage/webhooks'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to retrieve all the webhook events.
    #
    #
    # @return Model Class containing Definition for WebHookEventModel Property
    # 40.6
    def get_webhook_events()

      query_parameters = {}
      query_parameters['apikey'] = @api_key
      query_parameters['apisecret'] = @api_secret

      resource_path = 'v2/manage/webhooks/events'
      get_request(resource_path, query_parameters, {})
    end
  end
end
