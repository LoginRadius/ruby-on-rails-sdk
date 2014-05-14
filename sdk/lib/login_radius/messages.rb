module LoginRadius
  module Messages

    # Sends a Status message to on facebook. Params hash takes following keys:
    # access_token :- [Required parameter] access token 
    # title :- [optional parameter] status message title
    # url:- [optional parameter] any url that you want post in status message
    # imageurl :- [optional parameter] any image url that you want post in status message
    # status :- your status message
    # caption : [optional parameter] caption that you want post in status message
    # description :- [optional parameter] description  that you want post in status message
    #
    # @param params [Hash] 
    # @return [Boolean] Whether or not message succeeded
    def post_status!(params = {})
      call_api("api/v2/status/js", params)
    end
    def post_status(params = {})
      post_status!(params)
    rescue LoginRadius::Exception => e
      false
    end
    
    # Sends a Direct message to on facebook. Params hash takes following keys:
    # access_token :- [Required parameter] access token 
    # to :- [Required parameter] with whom you want post you direct message
    # subject :- [optional parameter] any subject that you want post in direct message
    # message :- [optional parameter] any message that you want post in direct message
    #
    # @param params [Hash] 
    # @return [Boolean] Whether or not message succeeded
    def direct_message!(params = {})
      call_api("api/v2/message/js", params)
    end
    def direct_message(params = {})
      direct_message!(params)
    rescue LoginRadius::Exception => e
      false
    end
  end
end
