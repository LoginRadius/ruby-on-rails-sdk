require_relative "../request_client"

module LoginRadius
  class Webhooks
    # Ruby wrapper for the LoginRadius Webhooks API module.
    include RequestClient

    BASE_RESOURCE = "/api/v2/webhook"
    
    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius Webhooks object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(required)
    # and custom_api_domain(optional)
    def initialize(options = {
      :site_name => "",
      :api_key => "",
      :api_secret => "",
      :custom_api_domain => ""
    })
    self.site_name = options[:site_name]
    self.api_key = options[:api_key]
    self.api_secret = options[:api_secret]
    self.custom_api_domain = options[:custom_api_domain]

    raise LoginRadius::Error.new("'site_name' is a required option for Webhooks class initialization.") \
      unless self.site_name != "" && self.site_name != nil
    raise LoginRadius::Error.new("'api_key' is a required option for Webhooks class initialization.") \
      unless self.api_key != "" && self.api_key != nil
    raise LoginRadius::Error.new("'api_secret is a required option for Webhooks class initialization.") \
      unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - WebHook Subscribe:
    # Subscribes a Webhook on your LoginRadius site.
    # https://docs.loginradius.com/api/v2/integrations/web-hook-subscribe-api
    #
    # @params target_url [String]          Url for trigger to send data to when webhook is invoked
    # @params event [String]               Event to send
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def webhook_subscribe(target_url, event)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "targeturl" => target_url,
        "event" => event
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end
    
    # GET - WebHook Test:
    # Tests subscribed Webhooks.
    # https://docs.loginradius.com/api/v2/integrations/web-hook-test
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def webhook_test()
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/test",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - WebHook Subscribed URLs:
    # Retrieves all subscribed URLs for a particular event.
    # https://docs.loginradius.com/api/v2/integrations/web-hook-subscribed-urls
    #
    # @params event [String]              Event to search for
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def webhook_subscribed_urls(event)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :event => event
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # DELETE - WebHook Unsubscribe:
    # Unsubscribes a Webhook configured on your LoginRadius site.
    # https://docs.loginradius.com/api/v2/integrations/web-hook-unsubscribe
    #
    # @params target_url [String]          Url configured for trigger to send data to when webhook is invoked
    # @params event [String]               Event configured to send
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def webhook_unsubscribe(target_url, event)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "targeturl" => target_url,
        "event" => event
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end
  end
end
