module LoginRadius
  module Two_FA_Api
    
  
  
    # ------------------------------------------------------------- Get API --------------------------------------------------------------------#
	
	
    def validateGoogleAuthCode_2FA(secondfactorauthenticationtoken,googleauthenticatorcode)
      return getRequest("identity/v2/auth/login/2fa/verification",{:apikey=> appkey,:secondfactorauthenticationtoken=> secondfactorauthenticationtoken,:googleauthenticatorcode=> googleauthenticatorcode},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	def validateOtp_2FA(secondfactorauthenticationtoken,otp,smstemplate2fa)
      return getRequest("identity/v2/auth/login/2fa/verification",{:apikey=> appkey,:secondfactorauthenticationtoken=> secondfactorauthenticationtoken,:otp=> otp,:smstemplate2fa=> smstemplate2fa},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  	  	  
	
	def validateAccessToken_2FA(access_token,smstemplate2fa)
      return getRequest("identity/v2/auth/account/2fa",{:apikey=> appkey,:access_token=> access_token,:smstemplate2fa=> smstemplate2fa},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	def validateBackupCode_2FA(secondfactorauthenticationtoken,backupcode)
      return getRequest("identity/v2/auth/login/2fa/backupcode",{:apikey=> appkey,:secondfactorauthenticationtoken=> secondfactorauthenticationtoken,:backupcode=> backupcode},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	def getBackupCode_2FA(access_token)
      return getRequest("identity/v2/auth/login/2fa/backupcode",{:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	def resetBackupCode_2FA(access_token)
      return getRequest("identity/v2/auth/account/2fa/backupcode/reset",{:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	def getBackupCodeByUid_2FA(uid)
      return getRequest("identity/v2/manage/account/2fa/backupcode",{:apikey=> appkey,:apisecret=>appsecret,:uid=> uid},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
    def resetBackupCodeByUid_2FA(uid)
      return getRequest("identity/v2/manage/account/2fa/backupcode/reset",{:apikey=> appkey,:apisecret=>appsecret,:uid=> uid},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	
	  
	
	  
	
	  
	  
      # ------------------------------------------------------------- Post API --------------------------------------------------------------------#	 
	  
	  
	 def emailLogin_2FA(email,password,loginurl,verificationurl,emailtemplate,smstemplate2fa)
	   param = {
        :apikey=> appkey,
        :loginurl=> loginurl,
        :verificationurl => verificationurl,
		:emailtemplate=> emailtemplate,
        :smstemplate2fa => smstemplate2fa
      }
	   payload = {
        :email=> email,
        :password => password
	  }
      return postRequest("identity/v2/auth/login/2fa",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	  
	  
	 def usernameLogin_2FA(username,password,loginurl,verificationurl,emailtemplate,smstemplate2fa)
	   param = {
        :apikey=> appkey,
        :loginurl=> loginurl,
        :verificationurl => verificationurl,
		:emailtemplate=> emailtemplate,
        :smstemplate2fa => smstemplate2fa
      }
	   payload = {
        :username=> username,
        :password => password
	  }
      return postRequest("identity/v2/auth/login/2fa",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	  
	 def phoneLogin_2FA(phone,password,loginurl,verificationurl,emailtemplate,smstemplate2fa)
	   param = {
        :apikey=> appkey,
        :loginurl=> loginurl,
        :verificationurl => verificationurl,
		:emailtemplate=> emailtemplate,
        :smstemplate2fa => smstemplate2fa
      }
	   payload = {
        :phone=> phone,
        :password => password
	  }
      return postRequest("identity/v2/auth/login/2fa",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	
	  
	   # ------------------------------------------------------------- Put API --------------------------------------------------------------------#	 
	   
	   

	def updatePhoneNumber_2FA(phoneno2fa,secondfactorauthenticationtoken,smstemplate2fa)
	  payload = {
        :phoneno2fa=> phoneno2fa
	  }
      return putRequest("identity/v2/auth/phone",{:apikey=> appkey,:secondfactorauthenticationtoken=> secondfactorauthenticationtoken,:smstemplate2fa=> smstemplate2fa},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end   
	  
	  
	def updatePhoneNumberByToken_2FA(phoneno2fa,access_token,smstemplate2fa)
	  payload = {
        :phoneno2fa=> phoneno2fa
	  }
      return putRequest("identity/v2/auth/phone",{:apikey=> appkey,:access_token=> access_token,:smstemplate2fa=> smstemplate2fa},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end   

	  

	  
	  # ------------------------------------------------------------- Delete API --------------------------------------------------------------------#
	  
	  
	  
	def resetGoogleAuthenticatorByToken_2FA(access_token,payload)
      return deleteRequest("identity/v2/auth/account/2fa/authenticator",{:apikey=> appkey,:access_token=> access_token},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def resetSmsAuthenticatorByToken_2FA(access_token,payload)
      return deleteRequest("identity/v2/auth/account/2fa/authenticator",{:apikey=> appkey,:access_token=> access_token},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def resetGoogleAuthenticatorByUid_2FA(uid,payload)
      return deleteRequest("identity/v2/manage/account/2fa/authenticator",{:apikey=> appkey,:apisecret=>appsecret,:uid=> uid},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end

	def resetSmsAuthenticatorByUid_2FA(uid,payload)
      return deleteRequest("identity/v2/manage/account/2fa/authenticator",{:apikey=> appkey,:apisecret=>appsecret,:uid=> uid},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end

	  

  end
end
