module LoginRadiusRaas
  module BasicApi
    #
    # LoginRadius function - Fetch LoginRadius access token after authentication. It will be valid for the specific duration of time specified in the response.
    # @param string LoginRadius API token
    #
    # @return mixed string|object LoginRadius access token.
    #
    #
    def get_access_token!(token)
      return api_client("api/v2/access_token", {:token=>token,:secret=>appsecret});
    end

    def get_access_token(token)
      return get_access_token!(token)
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
    def get_user_profile!(accessToken, raw)
      return api_client("api/v2/userprofile" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_user_profile(accessToken, raw = false)
      return get_user_profile!(accessToken, raw)
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
    def get_albums!(accessToken, raw)
      return api_client("api/v2/album" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_albums(accessToken, raw = false)
      return get_albums!(accessToken, raw)
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
    def get_photos!(accessToken, albumId, raw)
      return api_client("api/v2/photo" + get_row_data(raw), {:access_token=>accessToken,:albumid=>albumId});
    end

    def get_photos(accessToken, albumId, raw = false)
      return get_photos!(accessToken, albumId, raw)
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
    def get_checkins!(accessToken, raw)
      return api_client("api/v2/checkin" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_checkins(accessToken, raw = false)
      return get_checkins!(accessToken, raw)
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
    def get_audio!(accessToken, raw)
      return api_client("api/v2/audio" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_audio(accessToken, raw = false)
      return get_audio!(accessToken, raw)
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
    #
    def send_message!(accessToken, to, subject, message)
      param = {
        :access_token => accessToken,
        :to => to,
        :subject => subject,
        :message => message
      }
      return api_client("api/v2/message", param,{});
    end

    def send_message(accessToken, to, subject, message)
      return send_message!(accessToken, to, subject, message)
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
    def get_contacts!(accessToken, nextCursor, raw)
      return api_client("api/v2/contact" + get_row_data(raw), {:access_token=>accessToken,:nextcursor=>nextCursor});
    end

    def get_contacts(accessToken, nextCursor = '0', raw = false)
      return get_contacts!(accessToken, nextCursor, raw)
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
    def get_mentions!(accessToken, raw)
      return api_client("api/v2/mention" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_mentions(accessToken, raw = false)
      return get_mentions!(accessToken, raw)
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
    def get_following!(accessToken, raw)
      return api_client("api/v2/following" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_following(accessToken, raw = false)
      return get_following!(accessToken, raw)
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
    def get_events!(accessToken, raw)
      return api_client("api/v2/event" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_events(accessToken, raw = false)
      return get_events!(accessToken, raw)
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
    def get_posts!(accessToken, raw)
      return api_client("api/v2/post" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_posts(accessToken, raw = false)
      return get_posts!(accessToken, raw)
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
    def get_followed_companies!(accessToken, raw)
      return api_client("api/v2/company" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_followed_companies(accessToken, raw = false)
      return get_followed_companies!(accessToken, raw)
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
    def get_groups!(accessToken, raw)
      return api_client("api/v2/group" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_groups(accessToken, raw = false)
      return get_groups!(accessToken, raw)
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
    def get_status!(accessToken, raw)
      return api_client("api/v2/status" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_status(accessToken, raw = false)
      return get_status!(accessToken, raw)
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
    def post_status!(accessToken, title, url, imageurl, status, caption, description)
      param = {
        :access_token => accessToken,
        :title => title,
        :url => url,
        :imageurl => imageurl,
        :status => status,
        :caption => caption,
        :description => description
      }
      return api_client("api/v2/status", param, {});
    end

    def post_status(accessToken, title, url, imageurl, status, caption, description)
      return post_status!(accessToken, title, url, imageurl, status, caption, description)
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
    def get_videos!(accessToken, raw)
      return api_client("api/v2/video" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_videos(accessToken, raw = false)
      return get_videos!(accessToken, raw)
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
    def get_likes!(accessToken, raw)
      return api_client("api/v2/like" + get_row_data(raw), {:access_token=>accessToken});
    end

    def get_likes(accessToken, raw = false)
      return get_likes!(accessToken, raw)
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
    def get_pages!(accessToken, pageName, raw)
      return api_client("api/v2/page" + get_row_data(raw), {:access_token=>accessToken,:pagename=>pageName});
    end

    def get_pages(accessToken, pageName, raw = false)
      return get_pages!(accessToken, pageName, raw)
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
