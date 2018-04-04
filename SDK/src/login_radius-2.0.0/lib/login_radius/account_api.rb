module LoginRadiusRaas
  module AccountApi
    #
    # This API is used to link a user account with a specified providers user account.
    #
    # params = {
    #      :accountid => uid,
    #      :provider => Provider Name,
    #      :providerid => Social ID
    # }
    #
    # return {“isPosted”: “true”}
    #
    def account_link!(params)
      api_client("raas/v1/account/link", {}, params);
    end

    def account_link(params={})
      account_link!(params)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to unlink a user account with a specified providers user account.
    #
    # params = {
    #      :accountid => uid,
    #      :provider => Provider Name,
    #      :providerid => Social ID
    # }
    #
    # return {“isPosted”: “true”}
    #
    def account_unlink!(params)
      api_client("raas/v1/account/unlink", {}, params);
    end

    def account_unlink(params={})
      account_unlink!(params)
    rescue LoginRadiusRaas::Exception => e
      false
      end
    #
    # This API is used to delete a user account
    #
    # accountid => uid;
    #
    # return {“isPosted”: “true”}
    #
      def account_delete!(accountid)
      api_client("raas/v1/account/delete", {:accountid=>accountid});
    end

    def account_delete(accountid)
      account_delete!(accountid)
    rescue LoginRadiusRaas::Exception => e
      false
      end
    #
    # This API is used to changed username for a user account
    #
    # accountid = uid
    # currentusername = currentusername
    # newusername = newusername
    #
    # return {“isPosted”: “true”}
    #
      def account_change_username!(uid,currentusername,newusername)
      api_client("raas/v1/account/changeusername", {:accountid=>uid},{:currentusername=>currentusername,:newusername=>newusername}, 'json');
    end

    def account_change_username(uid,currentusername,newusername)
      account_change_username!(uid,currentusername,newusername)
    rescue LoginRadiusRaas::Exception => e
      false
      end
    #
    # This API is used to set username for a user account
    #
    # accountid = uid
    # username = username
    #
    # return {“isPosted”: “true”}
    #
    def account_set_username!(uid,username)
      api_client("raas/v1/account/setusername", {:accountid=>uid},{:newusername=>username}, 'json');
    end

    def account_set_username(uid,username)
      account_set_username!(uid,username)
    rescue LoginRadiusRaas::Exception => e
      false
      end
    #
    # This API is used to check username for a user account
    #
    # username = username
    #
    # return {“isExist”: “true”}
    #
      def account_check_username!(username)
      api_client("raas/client/auth/checkusername",{:username=>username});
    end

    def account_check_username(username)
      account_check_username!(username)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    
    #
    # This API is used to retrieve all of the profile data from each of the linked social provider accounts associated with the account. For ex: A user has linked facebook and google account then this api will retrieve both profile data.
    #
    # uid = xxxxxxxxxx;
    #
    # return Array of user profile
    #
    def account_get_profiles_by_uid!(uid)
      api_client("raas/v1/account", {:accountid=>uid});
    end

    def account_get_profiles_by_uid(uid)
      account_get_profiles_by_uid!(uid)
    rescue LoginRadiusRaas::Exception => e
      false
      end
  end
end
