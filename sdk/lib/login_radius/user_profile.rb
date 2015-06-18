require 'net/http'
module LoginRadius
  class UserProfile
    include UserProfileGetters
    include Messages
    include Related
    
    attr_accessor :secret, :token, :async, :ssl_verify_peer
    
    API_ROOT = "https://api.loginradius.com/"

    # Takes a hash of account secret, token, and connection type(net_http or em_http)
    # and uses it to auth against the LoginRadius API. Then it returns the Account object. The
    # async key is optional, if set to true, will use Em::HTTP instead of Net::HTTP.
    # 
    # @param opts [Hash] Must have keys :token, :secret, :async(optional) and :ssl_verify_peer(optional)
    # @return [LoginRadius::Account]
    def initialize(opts = {})
      self.token = opts[:token]
      self.secret = opts[:secret]
      self.async = opts[:async]
    self.ssl_verify_peer = opts[:ssl_verify_peer]
      raise LoginRadius::Exception.new("Invalid Request") unless token
      raise LoginRadius::Exception.new("Invalid Token") unless guid_valid?(token)
      raise LoginRadius::Exception.new("Invalid Secret") unless guid_valid?(secret)
    end

    # Takes a guid and returns whether or not it is valid.
    #
    # @param guid [String]
    # @return [Boolean]
    def guid_valid?(guid)
      guid.match(/^\{?[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}\}?$/i)
    end

    # Returns whether or not this object is authed.
    #
    # @return [Boolean]
    def authenticated?
      respond_to?(:access_token)
    end

    # Generic GET call function that other submodules can use to hit the API.
    #
    # @param url [String] Target URL to fetch data from.
    # @param params [Hash] Parameters to send
    # @return data [Hash] Parsed JSON data from the call
    def call_api(url, params = {})
      url = API_ROOT+url unless url.match(/^#{API_ROOT}/) #in case api root is included,
      #as would happen in a recursive redirect call.
      
      if async
        #UNTESTED
        #if async is true, we expect you to be using EM::Synchrony submodule and to be in an eventloop,
        #like with a thin server using the Cramp framework. Otherwise, this method blows up.
        response = EM::Synchrony.sync EventMachine::HttpRequest.new(url).aget :redirects => 2, :query => params
        response = response.response        
      else
        #synchronous version of the call.
        url_obj = URI.parse(url)
        url_obj.query = URI.encode_www_form(params)
        
        http = Net::HTTP.new(url_obj.host, url_obj.port)
    http.use_ssl = true
        if !ssl_verify_peer
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
        response = http.get(url_obj.request_uri)
        
        if response.is_a?(Net::HTTPTemporaryRedirect)
          #for some reason, we always get redirected when calling server first time.
          #so if we do, we scan body for the redirect url, and the scan returns
          #an array of arrays. So we grab the array we know has what we need,
          #and grab the first element.
          redirect_url_array = response.body.scan(/<a href=\"([^>]+)\">/i)[1]
          redirect_url = redirect_url_array.first
          return call_api(redirect_url, params) 
        end
        
        response = response.body
      end
      
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
        #converted_response = unconverted_response.is_a?(Hash) ?
        #                      Hash.lr_convert_hash_keys(unconverted_response).symbolize_keys! : 
        #                      unconverted_response.map { |item| Hash.lr_convert_hash_keys(item).symbolize_keys! 
  return converted_response
      rescue JSON::ParserError => e
        raise LoginRadius::Exception.new("A JSON parsing error occurred because the API returned an HTML page instead of JSON. This happens mostly when you're using an expired Token. Specifics: #{e.message}")
      end 
    end
  end
end
