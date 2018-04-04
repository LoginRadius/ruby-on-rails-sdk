module LoginRadius
  module AdvancedApi
   
   
   
   
     # ------------------------------------------------------------- Get API --------------------------------------------------------------------#
   
   

    def accesstokenViaFacebookToken(fb_access_token)
      return getRequest("api/v2/access_token/facebook", {:key=> appkey,:fb_access_token=>fb_access_token},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def accesstokenViaTwitterToken(tw_access_token,tw_token_secret)
      return getRequest("api/v2/access_token/twitter", {:key=> appkey,:tw_access_token=>tw_access_token,:tw_token_secret=>tw_token_secret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def accesstokenViaVkontakteToken(vk_access_token)
      return getRequest("api/v2/access_token/vkontakte", {:key=> appkey,:vk_access_token=>vk_access_token},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def getTrackableStatusStats(access_token,status,title,url,imageurl,caption,description)
	  param = {
        :access_token => access_token,
        :status=> status,
        :title => title,
		:url=> url,
        :imageurl => imageurl,
		:caption=> caption,
        :description => description
      }
      return getRequest("api/v2/status/trackable/js", param,"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def refreshUserProfile(access_token)
      return getRequest("api/v2/userprofile/refresh", {:access_token=> access_token},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def refreshToken(access_token)
      return getRequest("api/v2/userprofile/refresh", {:access_token=> access_token,:secret=> appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def shortenUrl(key,url)
      return getRequest("sharing/v1/shorturl", {:key=> appkey,:url=> url},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def trackableStatusFetching(postid)
      return getRequest("api/v2/status/trackable", {:secret=> appsecret,:postid=> postid},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def getActiveSessionDetails(token)
      return getRequest("api/v2/access_token/activesession", {:key=> appkey,:secret=> appsecret,:token=> token},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def webhookTest()
      return getRequest("api/v2/webhook/test", {:apikey=> appkey,:apisecret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def webhookSubscribedUrls(event)
      return getRequest("api/v2/webhook", {:apikey=> appkey,:apisecret=>appsecret,:event=>event},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  

	  
	   # ------------------------------------------------------------- Post API --------------------------------------------------------------------#	
	   
	   
	def trackableStatusPosting(access_token,payload)
      return postRequest("api/v2/status/trackable",{:access_token=> access_token},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def webhookSubscribe(payload)
      return postRequest("api/v2/webhook",{:apikey=> appkey,:apisecret=>appsecret},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  


    
	 # ---------------------------------------------------------- Delete API --------------------------------------------------------------------#	 
	 
	 
    def webhookUnsubscribe(payload)
      return deleteRequest("api/v2/webhook",{:apikey=> appkey,:apisecret=>appsecret},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	
  end
end
