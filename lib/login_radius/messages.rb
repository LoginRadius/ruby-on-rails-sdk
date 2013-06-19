module LoginRadius
  module Messages
    
    # Sends a message to a person using twitter
    #
    # @param sendto [String] Social ID of person you're contacting from contact list
    # @param subject [String]
    # @param message [String]
    # @return [Boolean] Whether or not message succeeded
    def send_twitter_message(sendto, subject, message)
      send_message({:sendto => sendto, :subject => subject, :message => message})
    end
    
    # Sends a message to a person using twitter
    #
    # @param sendto [String] Social ID of person you're contacting from contact list
    # @param subject [String]
    # @param message [String]
    # @return [Boolean] Whether or not message succeeded
    def send_twitter_message!(sendto, subject, message)
      send_message({:sendto => sendto, :subject => subject, :message => message})
    end
    
    # Sends a message to a person using linkedin
    #
    # @param sendto [String] Social ID of person you're contacting from contact list
    # @param subject [String]
    # @param message [String]
    # @return [Boolean] Whether or not message succeeded
    def send_linked_in_message(sendto, subject, message)
      send_message({:sendto => sendto, :subject => subject, :message => message})
    end
    
    # Sends a message to a person using linkedin
    #
    # @param sendto [String] Social ID of person you're contacting from contact list
    # @param subject [String]
    # @param message [String]
    # @return [Boolean] Whether or not message succeeded
    def send_linked_in_message!(sendto, subject, message)
      send_message!({:sendto => sendto, :subject => subject, :message => message})
    end
    
    # Sends a message to a person using facebook. Params hash takes following keys:
    # to(optional) :- Person's wall it's going to, if blank, is your own
    # title :- [optional parameter] status message title
    # url:- [optional parameter] any url that you want post in status message
    # imageurl :- [optional parameter] any image url that you want post in status message
    # status :- your status message
    # caption : [optional parameter] caption that you want post in status message
    # description :- [optional parameter] description  that you want post in status message
    #
    # @param params [Hash] 
    # @return [Boolean] Whether or not message succeeded
    def make_facebook_post!(params = {})
      call_api("status/update/#{secret}/#{token}", params)
    end
    
    # Sends a message to a person using facebook. Params hash takes following keys:
    # to(optional) :- Person's wall it's going to, if blank, is your own
    # title :- [optional parameter] status message title
    # url:- [optional parameter] any url that you want post in status message
    # imageurl :- [optional parameter] any image url that you want post in status message
    # status :- your status message
    # caption : [optional parameter] caption that you want post in status message
    # description :- [optional parameter] description  that you want post in status message
    #
    # @param params [Hash] 
    # @return [Boolean] Whether or not message succeeded
    def make_facebook_post(params = {})
      make_facebook_post!(params)
    rescue LoginRadius::Exception => e
      false
    end
    
    private
    
    # Sends a message to a person. Will use either twitter, facebook or linked in, depending
    # on where the person you're sending it to came from, and the keys present in the hash.
    # Other methods in this module describe the keys they use, they all call this method
    # with the proper keys for their service type.
    #
    # @param params [Hash] Params hash describing what you'd like to send. 
    # @return [Boolean] Whether or not message succeeded
    def send_message!(params = {})
      call_api("directmessage/#{secret}/#{token}",params)
    end
    
    # Sends a message to a person. Will use either twitter, facebook or linked in, depending
    # on where the person you're sending it to came from, and the keys present in the hash.
    # Other methods in this module describe the keys they use, they all call this method
    # with the proper keys for their service type.
    #
    # @param params [Hash] Params hash describing what you'd like to send. 
    # @return [Boolean] Whether or not message succeeded
    def send_message(params = {})
      send_message!(params)
    rescue LoginRadius::Exception => e
      false
    end
  end
end
