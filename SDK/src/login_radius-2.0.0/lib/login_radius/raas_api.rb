require 'net/http'

module LoginRadiusRaas
  class RaasApi
    include BasicApi
    include AccountApi
    include UserApi
    include CustomObjectApi

    attr_accessor :appkey, :appsecret, :ssl_verify_peer

    RAAS_API_DOMAIN = "https://api.loginradius.com/"
    RAAS_CDN_ENDPOINT = "https://cdn.loginradius.com/"
    # Takes a hash of account secret, token, and connection type(net_http or em_http)
    # and uses it to auth against the LoginRadius API. Then it returns the Account object. The
    # async key is optional, if set to true, will use Em::HTTP instead of Net::HTTP.
    #
    # @param opts [Hash] Must have keys :token, :secret, :async(optional) and :ssl_verify_peer(optional)
    # @return [LoginRadius::Account]
    def initialize(opts = {})
      self.appsecret = opts[:appsecret]
      self.appkey = opts[:appkey]
      self.ssl_verify_peer = opts[:ssl_verify_peer]
      raise LoginRadiusRaas::Exception.new("Invalid appkey") unless guid_valid?(appkey)
      raise LoginRadiusRaas::Exception.new("Invalid appsecret") unless guid_valid?(appsecret)
    end

    # Takes a guid and returns whether or not it is valid.
    #
    # @param guid [String]
    # @return [Boolean]
    def guid_valid?(guid)
      guid.match(/^\{?[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}\}?$/i)
    end

    # Generic GET call function that other submodules can use to hit the API.
    #
    # @param url [String] Target URL to fetch data from.
    # @param params [Hash] Parameters to send
    # @return data [Hash] Parsed JSON data from the call
    def api_client(url, getparams = {}, postparams='get', header='x-www-form-urlencoded')
      url = RAAS_API_DOMAIN + url unless url.match(/^#{RAAS_API_DOMAIN}/) #in case api root is included,
      url_obj = URI.parse(url)
      authentication  = {
        :appkey => appkey,
        :appsecret => appsecret
      }
      params = authentication.merge(getparams)
      url_obj.query = URI.encode_www_form(params)

      http = Net::HTTP.new(url_obj.host, url_obj.port)
      http.use_ssl = true
      if !ssl_verify_peer
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      if postparams == 'get'
      response = http.get(url_obj.request_uri)
      else
        if header == "json"
        postparamdata = postparams.to_json;
        else
        postparamdata = postparams.to_query;
        end
        response = http.post(url_obj.request_uri, postparamdata, {'Content-Type' => 'application/'+header })
      end

      if response.is_a?(Net::HTTPTemporaryRedirect)
        #for some reason, we always get redirected when calling server first time.
        #so if we do, we scan body for the redirect url, and the scan returns
        #an array of arrays. So we grab the array we know has what we need,
        #and grab the first element.
        redirect_url_array = response.body.scan(/<a href=\"([^>]+)\">/i)[1]
        redirect_url = redirect_url_array.first
        return api_client(redirect_url, getparams, postparams, header)
      end

      response = response.body

      # For some reason, this API returns true/false instead of JSON responses for certain calls.
      # We catch this here.
      return true if response.match(/^true/i)
      return false if response.match(/^false/i)

      #We rescue this because sometimes the API returns HTML pages(which can't be JSON parsed)
      #This mostly happens when people use expired tokens. So we go ahead and raise an exception
      #About it if it gets caught.
      begin
        converted_response = JSON.parse(response, :symbolize_names => true)
        #it's all String keys in CamelCase above, so...
        # IF we got a hash back, convert it directly, if its an array, convert each item which is a hash
        # into snake case
        # converted_response = unconverted_response.is_a?(Hash) ?
        # Hash.lr_convert_hash_keys(unconverted_response).symbolize_keys! :
        # unconverted_response.map { |item| Hash.lr_convert_hash_keys(item).symbolize_keys!
        return converted_response
      rescue JSON::ParserError => e
        raise LoginRadiusRaas::Exception.new("A JSON parsing error occurred because the API returned an HTML page instead of JSON. This happens mostly when you're using an expired Token. Specifics: #{e.message}")
      end
    end
  end
end
