module LoginRadius
  module SocialApi
    
	
    def authentication
     return authentication  = {
        :appkey => appkey,
        :appsecret => appsecret
      }
      end
   
    
	
	#
    # LoginRadius function - Fetch LoginRadius access token after authentication. It will be valid for the specific duration of time specified in the response.
    # @param string LoginRadius API token
    #
    # @return mixed string|object LoginRadius access token.
    #
    #
	
	
    def getAccessToken(token)
      return getRequest("api/v2/access_token", {:token=>token,:secret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end  
	  
	  
    #
    # LoginRadius function - Validate LoginRadius access token.This API validates access token, if valid then returns a response with its expiry otherwise error.
    # @param string LoginRadius API token
    # @return mixed string|object LoginRadius access token.
    #
    #
	
	
    def getValidateAccessToken(token)
      return getRequest("api/v2/access_token/validate", {:access_token=>token,:key=>appkey,:secret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end
	  
	  
    #
    # LoginRadius function - Invalidate LoginRadius access token.This api invalidates the active access token or expires an access token validity.
    # @param string LoginRadius API token
    # @return mixed string|object LoginRadius access token.
    #
    #
	
	
    def getInvalidateAccessToken(token)
      return getRequest("api/v2/access_token/invalidate", {:access_token=>token,:key=>appkey,:secret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end
   

    #
    # LoginRadius function - To get the Albums data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string accessToken LoginRadius access token
    # @param boolean raw If true, raw data is fetched
    #
    # @return object User's albums data.
    #
    #
	
	
   def getAlbums(accessToken, raw = false)
      return getRequest("api/v2/album" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	  
	#
    # LoginRadius function - To fetch user's audio files data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string accessToken LoginRadius access token
    # @param boolean raw If true, raw data is fetched
    #
    # @return object User's audio files data.
    #
    #

	
    def getAudios(accessToken, raw = false)
      return getRequest("api/v2/audio" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end 
	  
	  
	#
    # LoginRadius function - To fetch check-ins data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string accessToken LoginRadius access token
    # @param boolean raw If true, raw data is fetched
    #
    # @return object User's check-ins.
    #
    #

	
    def getCheckins(accessToken, raw = false)
      return getRequest("api/v2/checkin" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end  
	 
	 
	#
    # LoginRadius function - To get the followed company's data in the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object Companies followed by user.
    #

    def getCompanies(accessToken, raw = false)
      return getRequest("api/v2/company" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end 
	  
	  
	#
    # LoginRadius function - To fetch user's contacts/friends/connections data from the user's social account. The data will normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param integer $nextCursor Offset to start fetching contacts from
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object User's contacts/friends/followers.
    #
    #
    

    def getContacts(accessToken, nextCursor = '0', raw = false)
      return getRequest("api/v2/contact" + get_row_data(raw), {:access_token=>accessToken,:nextcursor=>nextCursor},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	#
    # LoginRadius function - To get the event data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object User's event data.
    #
   

    def getEvents(accessToken, raw = false)
      return getRequest("api/v2/event" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end 

	  
	#
    # LoginRadius function - To fetch information of the people, user is following on Twitter.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object Information of the people, user is following.
    #

    def getFollowing(accessToken, raw = false)
      return getRequest("api/v2/following" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	#
    # LoginRadius function - To get group data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object Group data.
    #

    def getGroups(accessToken, raw = false)
      return getRequest("api/v2/group" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	#
    # LoginRadius function - To get likes data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object likes data.
    #

    def getLikes(accessToken, raw = false)
      return getRequest("api/v2/like" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end  
	  
	  
	#
    # LoginRadius function - To get mention data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object User's twitter mentions.
    #

	
    def getMentions(accessToken, raw = false)
      return getRequest("api/v2/mention" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end


	#
    # LoginRadius function - Post messages to the user's contacts. After using the Contact API, you can send messages to the retrieved contacts.
    #
    # @param string $accessToken LoginRadius access token
    # @param string $to Social ID of the receiver
    # @param string $subject Subject of the message
    # @param string $message Message
    #
    # @return bool True on success, false otherwise
    #

	
    def postMessage(accessToken, to, subject, message)
     param = {
        :access_token => accessToken,
        :to => to,
        :subject => subject,
        :message => message
      }
      return postRequest("api/v2/message", param,{},nil,"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	  
	#
    # LoginRadius function - To get the page data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param string $pageName Page name
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object Page data.
    #
   
    def getPages(accessToken, pageName)
      return getRequest("api/v2/page", {:access_token=>accessToken,:pagename=>pageName},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	  
    #
    # LoginRadius function - To fetch photo data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string accessToken LoginRadius access token
    # @param string albumId ID of the album to fetch photos from
    # @param boolean raw If true, raw data is fetched
    #
    # @return object User's photo data.
    #
 

    def getPhotos(accessToken, albumId)
      return getRequest("api/v2/photo", {:access_token=>accessToken,:albumid=>albumId},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end


    #
    # LoginRadius function - To get posted messages from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object User's posted messages.
    #


    def getPosts(accessToken, raw = false)
      return getRequest("api/v2/post" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

   
    #
    # LoginRadius function - To get the status messages from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object Status messages.
    #

	
    def getStatus(accessToken, raw = false)
      return getRequest("api/v2/status" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	  
    #
    # LoginRadius function - To update the status on the user's wall.
    #
    # @param string $accessToken LoginRadius access token
    # @param string $title Title for status message (Optional).
    # @param string $url A web link of the status message (Optional).
    # @param string $imageurl An image URL of the status message (Optional).
    # @param string $status The status message text (Required).
    # @param string $caption Caption of the status message (Optional).
    # @param string $description Description of the status message (Optional).
    #
    # @return boolean Returns true if successful, false otherwise.
    #
 
 
    def postStatus(accessToken, title, url, imageurl, status, caption, description)
      param = {
        :access_token => accessToken,
        :title => title,
        :url => url,
        :imageurl => imageurl,
        :status => status,
        :caption => caption,
        :description => description
      }
      return postRequest("api/v2/status", param, {},nil,"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	#
    # LoginRadius function - To fetch social profile data from the user's social account after authentication. The social profile will be retrieved via oAuth and OpenID protocols. The data is normalized into LoginRadius' standard data format.
    #
    # @param string accessToken LoginRadius access token
    # @param boolean raw If true, raw data is fetched
    #
    # @return object User profile data.
    #

    def getUserProfile(accessToken, raw = false)
      return getRequest("api/v2/userprofile" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

	  
    #
    # LoginRadius function - To get videos data from the user's social account. The data will be normalized into LoginRadius' data format.
    #
    # @param string $accessToken LoginRadius access token
    # @param boolean $raw If true, raw data is fetched
    #
    # @return object Videos data.
    #
 
    def getVideos(accessToken, raw = false)
      return getRequest("api/v2/video" + get_row_data(raw), {:access_token=>accessToken},"api");
      rescue LoginRadiusRaas::Exception => e
      return false
      end

    

    

    #
    # LoginRadius function - To fetch data from the LoginRadius Raw API URL.
    #
    # @param boolean raw If true, raw data is fetched
    #
    # @return string Data to add in API URL.
    #
    def get_row_data(raw)
      if raw
        return '/raw';
      else
        return '';
      end
    end
  end
end
