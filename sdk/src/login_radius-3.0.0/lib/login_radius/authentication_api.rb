module LoginRadius
  module AuthenticationApi
    
  
  
    # ------------------------------------------------------------- Get API --------------------------------------------------------------------#
	
	
  
    def authCheckEmailAvailability(email)
      return getRequest("identity/v2/auth/email", {:email=>email,:apikey=>appkey},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end

	  
   
    def authCheckUserNameAvailability(username)
      return getRequest("identity/v2/auth/username", {:username=>username,:apikey=>appkey},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	
	
	def authReadAllProfiles(access_token)
      return getRequest("identity/v2/auth/account", {:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	
	def authSocialIdentity(access_token)
      return getRequest("identity/v2/auth/socialidentity", {:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authValidateAccessToken(access_token)
      return getRequest("identity/v2/auth/access_token/validate", {:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authVerifyEmail(verificationtoken,url,welcomeemailtemplate)
	 param = {
        :apikey=> appkey,
        :verificationtoken => verificationtoken,
        :url => url,
        :welcomeemailtemplate => welcomeemailtemplate
     }
      return getRequest("identity/v2/auth/email",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end

	  
    def auth_delete_account(deletetoken)
      return getRequest("identity/v2/auth/account/delete",{:apikey=> appkey,:deletetoken=> deletetoken},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authAccessTokenInvalidate(access_token)
      return getRequest("identity/v2/auth/access_token/invalidate",{:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authSecurityQuestionsByAccessToken(access_token)
      return getRequest("identity/v2/auth/securityquestion/accesstoken",{:apikey=> appkey,:access_token=> access_token},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	def authSecurityQuestionsByEmail(email)
      return getRequest("identity/v2/auth/securityquestion/email",{:apikey=> appkey,:email=> email},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def authSecurityQuestionsByUserName(username)
      return getRequest("identity/v2/auth/securityquestion/username",{:apikey=> appkey,:username=> username},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
    def authSecurityQuestionsByPhone(phone)
      return getRequest("identity/v2/auth/securityquestion/phone",{:apikey=> appkey,:phone=> phone},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def auth_phone_login_using_otp(phone,otp,smstemplate)
	  param = {
        :phone => phone,
        :apikey=> appkey,
        :otp => otp,
        :smstemplate => smstemplate
      }
      return getRequest("identity/v2/auth/login",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authPhoneNumberAvailability(phone)
      return getRequest("identity/v2/auth/phone",{:apikey=> appkey,:phone=> phone},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	def auth_phone_send_otp(phone,smstemplate)
      return getRequest("identity/v2/auth/login/otp",{:apikey=> appkey,:phone=> phone,:smstemplate=> smstemplate},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  	  
	
	  
	 def auth_instant_link_login_by_email(email,oneclicksignintemplate,verificationurl)
      return getRequest("identity/v2/auth/login/oneclicksignin",{:apikey=> appkey,:email=> email,:oneclicksignintemplate=> oneclicksignintemplate,:verificationurl=> verificationurl},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	  
	 def auth_instant_link_login_by_username(username,oneclicksignintemplate,verificationurl)
      return getRequest("identity/v2/auth/login/oneclicksignin",{:apikey=> appkey,:username=> username,:oneclicksignintemplate=> oneclicksignintemplate,:verificationurl=> verificationurl},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	 def auth_instant_login_verification(verificationtoken,welcomeemailtemplate)
      return getRequest("identity/v2/auth/login/oneclickverify",{:apikey=> appkey,:verificationtoken=> verificationtoken,:welcomeemailtemplate=> welcomeemailtemplate},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	 def authEmailPromptAutoLoginByEmail(email,clientguid,autologinemailtemplate,welcomeemailtemplate,redirecturl)
	  param = {
        :email => email,
        :apikey=> appkey,
        :clientguid => clientguid,
        :autologinemailtemplate => autologinemailtemplate,
		:welcomeemailtemplate => welcomeemailtemplate,
		:redirecturl => redirecturl
      }
      return getRequest("identity/v2/auth/login/autologin",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	 def authEmailPromptAutoLoginByUserName(username,clientguid,autologinemailtemplate,welcomeemailtemplate,redirecturl)
	  param = {
        :username => username,
        :apikey=> appkey,
        :clientguid => clientguid,
        :autologinemailtemplate => autologinemailtemplate,
		:welcomeemailtemplate => welcomeemailtemplate,
		:redirecturl => redirecturl
      }
      return getRequest("identity/v2/auth/login/autologin",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
     
	 
	 
	def authEmailPromptAutoLoginPing(clientguid)
      return getRequest("identity/v2/auth/login/autologin/ping",{:apikey=> appkey,:clientguid=> clientguid},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	 def authVerifyAutoLoginEmailForLogin(verificationtoken,welcomeEmailTemplate)
      return getRequest("identity/v2/auth/email/autologin",{:apikey=> appkey,:verificationtoken=> verificationtoken,:welcomeEmailTemplate=> welcomeEmailTemplate},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	 def authSimplifiedInstantRegistrationByEmail(email,name,clientguid,redirecturl,noregistrationemailtemplate,welcomeemailtemplate)
	  param = {
        :email  => email ,
        :apikey=> appkey,
        :name  => name,
        :clientguid => clientguid,
		:redirecturl => redirecturl,
		:noregistrationemailtemplate => noregistrationemailtemplate,
		:welcomeemailtemplate => welcomeemailtemplate
      }
      return getRequest("identity/v2/auth/noregistration/email",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	 def authSimplifiedInstantRegistrationByPhone(phone,name,smstemplate)
	  param = {
        :phone  => phone ,
        :apikey=> appkey,
        :name  => name,
        :smstemplate => smstemplate
      }
      return getRequest("identity/v2/auth/noregistration/phone",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	 def authCustomObjectByObjectrecordId(access_token,objectname,objectrecordid)
	  param = {
        :apikey=> appkey,
        :access_token  => access_token,
        :objectname => objectname
      }
      return getRequest("identity/v2/auth/customobject/"+objectrecordid,param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	 def authCustomObjectByToken(access_token,objectname)
	  param = {
        :apikey=> appkey,
        :access_token  => access_token,
        :objectname => objectname
      }
      return getRequest("identity/v2/auth/customobject",param,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	 def getConfigurations()
      return getRequest("ciam/appinfo",{:apikey=> appkey},"config");
	  rescue LoginRadiusRaas::Exception => e
      false
      end

	  
      # ------------------------------------------------------------- Post API --------------------------------------------------------------------#	 
	  
	  
	  
	  
	def authAddEmail(access_token,verificationurl,emailtemplate,payload)
	  param = {
        :access_token => access_token,
        :apikey=> appkey,
        :verificationurl => verificationurl,
        :emailtemplate => emailtemplate
      }
      return postRequest("identity/v2/auth/email",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authForgotPassword(resetpasswordurl,emailtemplate,payload)
	  param = {
        :resetpasswordurl => resetpasswordurl,
        :apikey=> appkey,
        :emailtemplate => emailtemplate
      }
      return postRequest("identity/v2/auth/password",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
 
	 def authUserRegistrationByEmail(verificationurl,emailtemplate,sott,payload)
	  param = {
        :verificationurl => verificationurl,
        :apikey=> appkey,
        :emailtemplate => emailtemplate
      }
      return postRequest("identity/v2/auth/register",param,payload,sott,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  def authUserRegistrationByPhone(smstemplate,verificationurl,sott,payload)
	  param = {
        :apikey=> appkey,
		:verificationurl => verificationurl,
        :smstemplate => smstemplate
	  }
      return postRequest("identity/v2/auth/register",param,payload,sott,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end   
	  
	  
	 def authLoginByEmail(verificationurl,loginurl,emailtemplate,recaptcha,payload)
	  param = {
        :verificationurl => verificationurl,
        :apikey=> appkey,
		:loginurl => loginurl,
        :emailtemplate => emailtemplate,
		:"g-recaptcha-response" => recaptcha
      }
      return postRequest("identity/v2/auth/login",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def authLoginByUserName(verificationurl,loginurl,emailtemplate,recaptcha,payload)
	  param = {
        :verificationurl => verificationurl,
        :apikey=> appkey,
		:loginurl => loginurl,
        :emailtemplate => emailtemplate,
		:"g-recaptcha-response" => recaptcha
      }
      return postRequest("identity/v2/auth/login",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	 def authLoginByPhone(verificationurl,loginurl,smstemplate,recaptcha,payload)
	  param = {
        :verificationurl => verificationurl,
        :apikey=> appkey,
		:loginurl => loginurl,
        :smstemplate => smstemplate,
		:"g-recaptcha-response" => recaptcha
      }
      return postRequest("identity/v2/auth/login",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	 def authForgotPasswordByOtp(smstemplate,payload)
	  param = {
        :apikey=> appkey,
        :smstemplate => smstemplate
	  }
      return postRequest("identity/v2/auth/password/otp",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	 def authPhoneResendOtp(smstemplate,payload)
	  param = {
        :apikey=> appkey,
        :smstemplate => smstemplate
	  }
      return postRequest("identity/v2/auth/phone/otp",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	  
	def authPhoneResendOtpByToken(access_token,smstemplate)
	  param = {
        :apikey=> appkey,
		:access_token => access_token,
        :smstemplate => smstemplate
	  }
      return postRequest("identity/v2/auth/phone/otp",param,{},nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
    def authCreateCustomObjectByToken(access_token,objectname,payload)
	  param = {
        :apikey=> appkey,
        :access_token => access_token,
		:objectname => objectname
	  }
      return postRequest("identity/v2/auth/customobject",param,payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end  	  


	  
	   # ------------------------------------------------------------- Put API --------------------------------------------------------------------#	 
	   
	   

	def authPhoneNumberUpdate(access_token,phone,smstemplate)
	   payload = {
        :phone=> phone
	  }
      return putRequest("identity/v2/auth/phone",{:apikey=> appkey,:access_token=> access_token,:smstemplate=> smstemplate},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end   

	  
	  
    def authPhoneResetPasswordByOtp(payload)
      return putRequest("identity/v2/auth/password/otp",{:apikey=> appkey},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	  
	def authPhoneVerificationByOtp(otp,phone,smstemplate)
	  payload = {
        :phone=> phone
      }
      return putRequest("identity/v2/auth/phone/otp",{:apikey=> appkey,:otp=> otp,:smstemplate=> smstemplate},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end

    
	def authPhoneVerificationOtpByToken(access_token,otp,smstemplate)
      return putRequest("identity/v2/auth/phone/otp",{:apikey=> appkey,:access_token=> access_token,:otp=> otp,:smstemplate=> smstemplate},{},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end


	def auth_reset_phone_id_verification(uid)
      return putRequest("identity/v2/manage/account/"+uid+"/invalidatephone",{:apikey=> appkey,:apisecret=>appsecret},{},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end


    def authChangePassword(access_token,oldpassword,newpassword)
	   payload = {
        :oldpassword=> oldpassword,
		:newpassword=>newpassword
	   }
      return putRequest("identity/v2/auth/password",{:apikey=> appkey,:access_token=>access_token},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end	


    def authLinkSocialIdentities(access_token,candidatetoken)
	  payload = {
        :candidatetoken=> candidatetoken
	   }
      return putRequest("identity/v2/auth/socialidentity",{:apikey=> appkey,:access_token=>access_token},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end  	


    def authResendEmailVerification(verificationurl,emailtemplate,payload)
      return putRequest("identity/v2/auth/register",{:apikey=> appkey,:verificationurl=>verificationurl,:emailtemplate=>emailtemplate},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 



    def authResetPasswordByResetToken(payload)
      return putRequest("identity/v2/auth/password",{:apikey=> appkey},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 

	  
    def authResetPasswordBySecurityAnswerAndEmail(payload)
      return putRequest("identity/v2/auth/password/securityanswer",{:apikey=> appkey},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authResetPasswordBySecurityAnswerAndUserName(payload)
      return putRequest("identity/v2/auth/password/securityanswer",{:apikey=> appkey},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authResetPasswordBySecurityAnswerAndPhone(payload)
      return putRequest("identity/v2/auth/password/securityanswer",{:apikey=> appkey},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end


    def authChangeUserName(access_token,username)
	  payload = {
        :username=> username
	  }
      return putRequest("identity/v2/auth/username",{:apikey=> appkey,:access_token=> access_token},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end	

   
    def authUpdateProfileByToken(access_token,verificationurl,emailtemplate,smstemplate,payload)
      return putRequest("identity/v2/auth/account",{:apikey=> appkey,:access_token=> access_token,:verificationurl=> verificationurl,:emailtemplate=> emailtemplate,:smstemplate=> smstemplate},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end		  
 	  
	  
	def authUpdateSecurityQuestionByAccessToken(access_token,payload)
      return putRequest("identity/v2/auth/account",{:apikey=> appkey,:access_token=> access_token},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  	 
	def authCustomObjectUpdateByToken(access_token,objectname,updatetype,objectrecordid,payload)
      return putRequest("identity/v2/auth/customobject/"+objectrecordid,{:apikey=> appkey,:access_token=> access_token,:objectname=> objectname,:updatetype=> updatetype},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	 def authSimplifiedInstantRegistrationOtpVerification(otp,smstemplate,phone)
	  param = {
        :apikey=> appkey,
        :otp  => otp,
        :smstemplate => smstemplate
      }
	   payload = {
       :phone=> phone
      }
      return putRequest("identity/v2/auth/noregistration/phone/verify",param,payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  # ------------------------------------------------------------- Delete API --------------------------------------------------------------------#
	  
	  
	  
	def authDeleteAccountWithEmailConfirmation(access_token,deleteurl,emailtemplate)
      return deleteRequest("identity/v2/auth/account",{:apikey=> appkey,:access_token=> access_token,:deleteurl=> deleteurl,:emailtemplate=> emailtemplate},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end

	  
	def authRemoveEmail(access_token,email)
	   payload = {
       :email=> email
      }
      return deleteRequest("identity/v2/auth/email",{:apikey=> appkey,:access_token=> access_token},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def authUnlinkSocialIdentities(access_token,payload)
      return deleteRequest("identity/v2/auth/socialidentity",{:apikey=> appkey,:access_token=> access_token},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def authCustomObjectDeleteByRecordId(access_token,objectname,objectrecordid)
      return deleteRequest("identity/v2/auth/customobject/"+objectrecordid,{:apikey=> appkey,:access_token=> access_token,:objectname=> objectname},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	 
	  


  end
end
