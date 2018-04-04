require 'net/http'

module LoginRadius
  class RestRequest
    include SocialApi
    include AdvancedApi
    include AuthenticationApi
    include ManagementApi
	include Two_FA_Api

    attr_accessor :appkey, :appsecret, :ssl_verify_peer

    API_V2_BASE_URL  = "https://api.loginradius.com/"
    API_V2_BASE_URL_CONFIG = "https://config.lrcontent.com/"
	API_V2_BASE_URL_CLOUD = "https://cloud-api.loginradius.com/"
	
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
	
	
	
	
	def getRequest(url,getparams = {},baseURL)
	if baseURL == "cloud"
	 url_obj = URI.parse(API_V2_BASE_URL_CLOUD+url)
	elsif  baseURL == "config"
	url_obj = URI.parse(API_V2_BASE_URL_CONFIG+url)
	else
	url_obj = URI.parse(API_V2_BASE_URL+url)
	end
    url_obj.query = URI.encode_www_form(getparams)
	http = Net::HTTP.new(url_obj.host, url_obj.port)
	http.use_ssl = true
	response = http.get(url_obj.request_uri)
	begin
    converted_response = JSON.parse(response.body, :symbolize_names => true)
    return converted_response
    rescue JSON::ParserError => e
    raise LoginRadiusRaas::Exception.new("A JSON parsing error occurred because the API returned an HTML page instead of JSON. This happens mostly when you're using an expired Token. Specifics: #{e.message}")
   end
end
	
	
	
	def postRequest(url,getparams = {},postparams,sott,baseURL)
	if baseURL == "cloud"
	 url_obj = URI.parse(API_V2_BASE_URL_CLOUD+url)
	elsif  baseURL == "config"
	url_obj = URI.parse(API_V2_BASE_URL_CONFIG+url)
	else
	url_obj = URI.parse(API_V2_BASE_URL+url)
	end
    url_obj.query = URI.encode_www_form(getparams)
	http = Net::HTTP.new(url_obj.host, url_obj.port)
	http.use_ssl = true
	if sott!=nil
    response = http.post(url_obj.request_uri, postparams.to_json, {'Content-Type' => 'application/json', 'X-LoginRadius-Sott' => sott})
    else
    response = http.post(url_obj.request_uri, postparams.to_json, {'Content-Type' => 'application/json'})
    end
	begin
    converted_response = JSON.parse(response.body, :symbolize_names => true)
    return converted_response
    rescue JSON::ParserError => e
    raise LoginRadiusRaas::Exception.new("A JSON parsing error occurred because the API returned an HTML page instead of JSON. This happens mostly when you're using an expired Token. Specifics: #{e.message}")
   end
end



def putRequest(url,getparams = {},postparams,baseURL)

	if baseURL == "cloud"
	 url_obj = URI.parse(API_V2_BASE_URL_CLOUD+url)
	elsif  baseURL == "config"
	url_obj = URI.parse(API_V2_BASE_URL_CONFIG+url)
	else
	url_obj = URI.parse(API_V2_BASE_URL+url)
	end
    url_obj.query = URI.encode_www_form(getparams)
	http = Net::HTTP.new(url_obj.host, url_obj.port)
	http.use_ssl = true
	response = http.put(url_obj.request_uri, postparams.to_json, {'Content-Type' => 'application/json'})
	begin
    converted_response = JSON.parse(response.body, :symbolize_names => true)
    return converted_response
    rescue JSON::ParserError => e
    raise LoginRadiusRaas::Exception.new("A JSON parsing error occurred because the API returned an HTML page instead of JSON. This happens mostly when you're using an expired Token. Specifics: #{e.message}")
   end
end


def deleteRequest(url,getparams = {},postparams)
    url_obj = URI.parse(API_V2_BASE_URL+url)
    url_obj.query = URI.encode_www_form(getparams)
	require 'uri'
    require 'net/http'
    url = URI("https://api.loginradius.com"+url_obj.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = false
    request = Net::HTTP::Delete.new(url)
    request.body = postparams.to_json #"{\n  \"provider\": \"xxxxxxxxxxx\",\n  \"providerid\": \"xxxxxxxxxxxxxxxxxxx\"\n}"
    request['content-Type'] = 'application/json'
    response = http.request(request)
	begin
    converted_response = JSON.parse(response.read_body, :symbolize_names => true)
    return converted_response
    rescue JSON::ParserError => e
    raise LoginRadiusRaas::Exception.new("A JSON parsing error occurred because the API returned an HTML page instead of JSON. This happens mostly when you're using an expired Token. Specifics: #{e.message}")
   end
end
	
	
   
  end
end
