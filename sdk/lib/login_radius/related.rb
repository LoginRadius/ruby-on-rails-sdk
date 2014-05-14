module LoginRadius
  module Related
    # fetch images with respact album id. Params hash takes following keys:
    # access_token :- [Required parameter] access token 
    # albumid :- [Required parameter] albumid for fetch images from album
    #
    # @param params [Hash] 
    # @return [Boolean] Whether or not message succeeded
    
    def photo!(params = {})
      call_api("api/v2/photo", params)
    end
    def photo(params = {})
      photo!(params)
    rescue LoginRadius::Exception => e
      false
    end
    
    # fetch page with respact PageNameOrId. Params hash takes following keys:
    # access_token :- [Required parameter] access token 
    # pagename :- [Required parameter] pagename for fetch page details from provider
    #
    # @param params [Hash] 
    # @return [Boolean] Whether or not message succeeded
    def page!(params = {})
      call_api("api/v2/page", params)
    end
    def page(params = {})
      page!(params)
    rescue LoginRadius::Exception => e
      false
    end
  end
end
