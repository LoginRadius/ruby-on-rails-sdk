require "net/http"

module LoginRadius
  module RequestClient
    # LoginRadius Client Module: Methods relating to building and sending requests are defined here.

    API_V2_BASE_URL = "https://api.loginradius.com"
    API_V2_BASE_URL_CONFIG = "https://config.lrcontent.com"
    API_V2_BASE_URL_CLOUD = "https://cloud-api.loginradius.com"

    # Sends a POST API request.
    #
    # @param uri_obj [URI]              Target uri instance
    # @param params [Hash]              Parameters to send
    # @param headers [Hash]             Request headers
    # @param body [Hash]                POST body
    #
    # @return [LoginRadius::Response]   LoginRadius response instance
    def post_request(uri_obj, params, headers, body = {})
      uri_obj.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri_obj.host, uri_obj.port)
      http.use_ssl = true
      response = http.post(uri_obj.request_uri, body.to_json, headers)

      begin
        return LoginRadius::Response.new(response)
      rescue JSON::ParserError => e
        raise LoginRadius::Error.new("JSON parsing error has occurred. More info: #{e.message}")        
      end
    end

    # Sends a GET API request.
    #
    # @param uri_obj [URI]              Target uri instance
    # @param params [Hash]              Parameters to send
    # @param headers [Hash]             Request headers
    #
    # @return [LoginRadius::Response]   LoginRadius response instance
    def get_request(uri_obj, params, headers = {})
      uri_obj.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri_obj.host, uri_obj.port)
      http.use_ssl = true
      response = http.get(uri_obj.request_uri, headers)

      begin
        return LoginRadius::Response.new(response)
      rescue JSON::ParserError => e
        raise LoginRadius::Error.new("JSON parsing error has occurred. More info: #{e.message}")
      end
    end

    # Sends a PUT API request.
    #
    # @param uri_obj [URI]              Target uri instance
    # @param params [Hash]              Parameters to send
    # @param headers [Hash]             Request headers
    # @param body [Hash]                PUT body
    #
    # @return [LoginRadius::Response]   LoginRadius response instance
    def put_request(uri_obj, params, headers = {}, body = {})
      uri_obj.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri_obj.host, uri_obj.port)
      http.use_ssl = true
      response = http.put(uri_obj.request_uri, body.to_json, headers)

      begin
        return LoginRadius::Response.new(response)
      rescue JSON::ParserError => e
        raise LoginRadius::Error.new("JSON parsing error has occurred. More info: #{e.message}")
      end
    end

    # Sends a DELETE API request.
    #
    # @param uri_obj [URI]              Target uri instance
    # @param type [String]              api/cloud/config, which base url to use
    # @param params [Hash]              Parameters to send
    # @param headers [Hash]             Request headers
    # @param body [Hash]                POST body
    #
    # @return [LoginRadius::Response]   LoginRadius response instance
    def delete_request(uri_obj, params, headers = {}, body = {})
      uri_obj.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri_obj.host, uri_obj.port)
      http.use_ssl = true
      req = Net::HTTP::Delete.new(uri_obj.request_uri, headers)
      req.body = body.to_json
      response = http.request(req)

      begin
        return LoginRadius::Response.new(response)
      rescue JSON::ParserError => e
        raise LoginRadius::Error.new("JSON parsing error has occurred. More info: #{e.message}")
      end
    end

    # Builds a URI instance given type and resource
    #
    # @param resource [String]           Target resource
    # @param type [String]               api/cloud/config, which base url to use, ignored if
    #                                    custom_api_domain is set
    # @param custom_api_domain [String]  Custom API Domain to replace base URL
    #
    # @return [URI]                      uri instance
    def build_uri_obj(resource, type, custom_api_domain)
      if custom_api_domain == "" || custom_api_domain == nil
        if type == "api"
          return URI.parse(API_V2_BASE_URL + resource)
        elsif type == "cloud"
          return URI.parse(API_V2_BASE_URL_CLOUD + resource)
        elsif type == "config"
          return URI.parse(API_V2_BASE_URL_CONFIG + resource)
        else
          raise LoginRadius::Error.new("Type must have a value of 'api', 'cloud', or 'config.")
        end
      else
        return URI.parse(custom_api_domain + resource)
      end
    end
  end
end
