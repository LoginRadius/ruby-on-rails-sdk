module LoginRadius
  module ManagementApi
   
   
   
    # ------------------------------------------------------------- Get API --------------------------------------------------------------------#
   
   
   
   def accountIdentitiesByEmail(email)
      return getRequest("identity/v2/manage/account/identities", {:apikey=> appkey,:apisecret=>appsecret,:email=>email},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
   

    def userImpersonation(uid)
      return getRequest("identity/v2/manage/account/access_token", {:apikey=> appkey,:apisecret=>appsecret,:uid=>uid},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def accountPassword(uid)
      return getRequest("identity/v2/manage/account/"+uid+"/password", {:apikey=> appkey,:apisecret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def accountProfileByEmail(email)
      return getRequest("identity/v2/manage/account", {:apikey=> appkey,:apisecret=>appsecret,:email=>email},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def accountProfileByUserName(username)
      return getRequest("identity/v2/manage/account", {:apikey=> appkey,:apisecret=>appsecret,:username=>username},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def accountProfileByPhone(phone)
      return getRequest("identity/v2/manage/account", {:apikey=> appkey,:apisecret=>appsecret,:phone=>phone},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def accountProfileByUid(uid)
      return getRequest("identity/v2/manage/account/"+uid, {:apikey=> appkey,:apisecret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def getContextWithRolesAndPermissions(uid)
      return getRequest("identity/v2/manage/account/"+uid+"/rolecontext", {:apikey=> appkey,:apisecret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end

	  
	def getRolesList()
      return getRequest("identity/v2/manage/role", {:apikey=> appkey,:apisecret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def getRolesByUid(uid)
      return getRequest("identity/v2/manage/account/"+uid+"/role", {:apikey=> appkey,:apisecret=>appsecret},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def getCustomObjectByObjectrecordIdAndUid(objectname,uid,objectrecordid)
      return getRequest("identity/v2/manage/account/"+uid+"/customobject/"+objectrecordid, {:apikey=> appkey,:apisecret=>appsecret,:objectname=>objectname},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def getCustomObjectByUid(objectname,uid)
      return getRequest("identity/v2/manage/account/"+uid+"/customobject", {:apikey=> appkey,:apisecret=>appsecret,:objectname=>objectname},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def generateSott(timedifference)
      return getRequest("identity/v2/manage/account/sott", {:apikey=> appkey,:apisecret=>appsecret,:timedifference=>timedifference},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def getServerTime(timedifference)
      return getRequest("identity/v2/serverinfo", {:apikey=> appkey,:timedifference=>timedifference},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  


    def getRegistrationData(type,parentid,skip,limit)
      return getRequest("identity/v2/manage/registrationdata/"+type, {:apikey=> appkey,:parentid=>parentid,:skip=>skip,:limit=>limit},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end	
	  
	def getRegistrationDataServer(type,parentid,skip,limit)
      return getRequest("identity/v2/auth/registrationdata/"+type, {:apikey=> appkey,:apisecret=>appsecret,:parentid=>parentid,:skip=>skip,:limit=>limit},"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
      # ------------------------------------------------------------- Post API --------------------------------------------------------------------#	
		 
	
    def accountCreate(payload)
      return postRequest("identity/v2/manage/account",{:apikey=> appkey,:apisecret=>appsecret},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end

		 
    def getEmailVerificationToken(payload)
      return postRequest("identity/v2/manage/account/verify/token",{:apikey=> appkey,:apisecret=>appsecret},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	def getForgotPasswordToken(payload)
      return postRequest("identity/v2/manage/account/forgot/token",{:apikey=> appkey,:apisecret=>appsecret},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def rolesCreate(payload)
      return postRequest("identity/v2/manage/role",{:apikey=> appkey,:apisecret=>appsecret},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def createCustomObjectByUid(objectname,uid,payload)
      return postRequest("identity/v2/manage/account/"+uid+"/customobject",{:apikey=> appkey,:apisecret=>appsecret,:objectname =>objectname },payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	
	def addRegistrationData(payload)
      return postRequest("identity/v2/manage/registrationdata",{:apikey=> appkey,:apisecret=>appsecret},payload,nil,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end 
	  
	def ValidateSecretCode(payload)
      return postRequest("identity/v2/auth/registrationdata/validatecode", {:apikey=> appkey},payload,nil,"api");
      rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  # ------------------------------------------------------------- Put API --------------------------------------------------------------------#	
	  
	  
	def accountSetPasswordToken(uid,payload)
      return putRequest("identity/v2/manage/account/"+uid+"/password",{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end


    def accountUpdate(uid,payload)
      return putRequest("identity/v2/manage/account/"+uid,{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end


    def accountUpdateSecurityQuestionConfiguration(uid,payload)
      return putRequest("identity/v2/manage/account/"+uid,{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end	


    def accountInvalidateVerificationEmail(uid,verificationurl,emailtemplate)
      return putRequest("identity/v2/manage/account/"+uid+"/invalidateemail",{:apikey=> appkey,:apisecret=>appsecret,:verificationurl=>verificationurl,:emailtemplate=>emailtemplate},{},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end		  

	  
	def accountAddPermissionsToRole(role,payload)
      return putRequest("identity/v2/manage/role/"+role+"/permission",{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def roleAssignToUser(uid,payload)
      return putRequest("identity/v2/manage/account/"+uid+"/role",{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def upsertContext(uid,payload)
      return putRequest("identity/v2/manage/account/"+uid+"/rolecontext",{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def customObjectUpdateByUid(objectname,updatetype,uid,objectrecordid,payload)
      return putRequest("identity/v2/manage/account/"+uid+"/customobject/"+objectrecordid,{:apikey=> appkey,:apisecret=>appsecret,:updatetype=> updatetype,:objectname=>objectname},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	  
	 def resetPhoneIdVerification(uid)
      return putRequest("identity/v2/manage/account/"+uid+"/invalidatephone",{:apikey=> appkey,:apisecret=>appsecret},{},"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	 def updateRegistrationData(recordid,payload)
      return putRequest("identity/v2/manage/registrationdata/"+recordid,{:apikey=> appkey,:apisecret=>appsecret},payload,"api");
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  # ------------------------------------------------------------- Delete API --------------------------------------------------------------------#
	  
	  
	  
	def accountEmailDelete(uid,email)
	  payload = {
       :email=> email
      }
      return deleteRequest("identity/v2/manage/account/"+uid+"/email",{:apikey=> appkey,:apisecret=>appsecret},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	def accountDelete(uid)
      return deleteRequest("identity/v2/manage/account/"+uid,{:apikey=> appkey,:apisecret=>appsecret},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	 
	 
	def accountDeleteRole(uid)
      return deleteRequest("identity/v2/manage/role/"+uid,{:apikey=> appkey,:apisecret=>appsecret},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def roleUnassignToUser(uid,payload)
      return deleteRequest("identity/v2/manage/account/"+uid+"/role",{:apikey=> appkey,:apisecret=>appsecret},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def accountRemovePermission(roleName,payload)
      return deleteRequest("identity/v2/manage/role/"+roleName+"/permission",{:apikey=> appkey,:apisecret=>appsecret},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def deleteRoleContext(uid,rolecontextname)
      return deleteRequest("identity/v2/manage/account/"+uid+"/rolecontext/"+rolecontextname,{:apikey=> appkey,:apisecret=>appsecret},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def deleteRoleFromContext(uid,rolecontextname,payload)
      return deleteRequest("identity/v2/manage/account/"+uid+"/rolecontext/"+rolecontextname+"/role",{:apikey=> appkey,:apisecret=>appsecret},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def deleteAdditionalPermissionsFromContext(uid,rolecontextname,payload)
      return deleteRequest("identity/v2/manage/account/"+uid+"/rolecontext/"+rolecontextname+"/additionalpermission",{:apikey=> appkey,:apisecret=>appsecret},payload);
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
	def deleteCustomObjectByObjectrecordId(uid,objectrecordid,objectname)
      return deleteRequest("identity/v2/manage/account/"+uid+"/customobject/"+objectrecordid,{:apikey=> appkey,:apisecret=>appsecret,:objectname=>objectname},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	def deleteRegistrationData(recordid)
      return deleteRequest("identity/v2/manage/registrationdata/"+recordid,{:apikey=> appkey,:apisecret=>appsecret},{});
	  rescue LoginRadiusRaas::Exception => e
      false
      end
	  
	  
  end
end
