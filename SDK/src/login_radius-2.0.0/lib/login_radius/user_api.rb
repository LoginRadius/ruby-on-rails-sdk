module LoginRadiusRaas
  module UserApi
    #
    # This API is used to create a new user on your site. This API bypasses the normal email verification process and manually creates the user for your system.
    #
    # params = {:emailid => "example@example.com",
    # :password => "FakePass",
    # :firstname => "Joe",
    # :lastname => "Smith",
    # :gender => "M",
    # :birthdate => "11-08-1987",
    # :Country => "USA",
    # :city => "Chicago",
    # :state => "Illinois ",
    # :phonenumber => "1232333232",
    # :address1 => "23/43, II Street",
    # :address2 => "Near Paris garden",
    # :company => "Orange Inc.",
    # :postalcode => "43435",
    # :emailsubscription => "true",
    # :customfields => {
    #      :example_field1 => "some data 1",
    #      :example_field2 => "some data 2",
    #      :example_field3 => "some data 3"
    # }
    # }
    #
    # return all user profile
    #
    def user_create_profile!(params)
      api_client("raas/v1/user", {}, params, 'json');
    end

    def user_create_profile(params={})
      user_create_profile!(params)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API used to register user from server side, verification email will be send to provided email address
    #
    # params = {"emailid => "example@example.com",
    # :password => "FakePass",
    # :firstname => "Joe",
    # :lastname => "Smith",
    # :gender => "M",
    # :birthdate => "11-08-1987",
    # :Country => "USA",
    # :city => "Chicago",
    # :state => "Illinois ",
    # :phonenumber => "1232333232",
    # :address1 => "23/43, II Street",
    # :address2 => "Near Paris garden",
    # :company => "Orange Inc.",
    # :postalcode => "43435",
    # :emailsubscription => "true",
    # :customfields => {
    #      :example_field1 => "some data 1",
    #      :example_field2 => "some data 2",
    #      :example_field3 => "some data 3"
    # },
    # :EmailVerificationUrl => "http://yoursite.com/verifyemail"
    # }
    #
    # return "isPosted": "true"
    #
    def user_registration!(params)
      api_client("raas/v1/user/register", {}, params, 'json');
    end

    def user_registration(params)
      user_registration!(params)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to Modify/Update details of an existing user.
    #
    # params = {
    #  :firstname => 'first name',
    #  :lastname => 'last name',
    #  :gender => 'm',
    #  :birthdate => 'MM-DD-YYYY',
    #  ....................
    #  ....................
    # }
    #
    # return {“isPosted”: “true”}
    #
    def user_edit_profile!(userId, params)
      api_client("raas/v1/user", {:userid => userId}, params, 'json');
    end

    def user_edit_profile(userId, params={})
      user_edit_profile!(userId, params)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to check email of an existing user.
    #
    # email = example@provider.com
    #
    # return {“isExist”: “true”}
    #

    def check_email!(email)
      api_client("raas/client/auth/checkEmail", {:email => email});
    end

    def check_email(email)
      check_email!(email)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to get token for forgot password of an existing user.
    #
    # email = example@provider.com
    #
    # return object of token and provider list
    #

    def user_forgot_password_token!(email)
      api_client("raas/v1/user", {:email => email});
    end

    def user_forgot_password_token(email)
      user_forgot_password_token!(email)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API deletes the RaaS account of the user and allowing them to begin the registration process
    #
    # return [{"isPosted": "true"}]
    #
    def user_delete!(uid)
      api_client("raas/v1/user/delete", {:UID => uid});
    end

    def user_delete(uid)
      user_delete!(uid)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to create a user using the currently logged in social provider.
    #
    # params = {
    #      :accountid => uid,
    #      :password => 'xxxxxxxxxx',
    #      :emailid => 'example@doamin.com'
    # }
    #
    # return {“isPosted”: “true”}
    #
    def user_set_password!(params)
      api_client("raas/v1/account/profile", {}, params, 'json');
    end

    def user_set_password(params={})
      user_set_password!(params)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to Update/Change the user’s password.
    #
    # userId => 'xxxxxxxxxx';
    # oldpassword => 'xxxxxxxxxx';
    # newpassword => 'xxxxxxxxxx';
    #
    # return {“isPosted”: “true”}
    #
    def user_change_password!(uid, oldPassword, newPassword)
      data = {:oldpassword => oldPassword, :newpassword => newPassword}
      api_client("raas/v1/account/password", {:accountid => uid}, data)
    end

    def user_change_password(uid, oldPassword, newPassword)
      user_change_password!(uid, oldPassword, newPassword)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to set the password of user, used in admin section.
    #
    # userId = 'xxxxxx'; // RaaS account ID only not Social Account ID
    # password = 'xxxxxxxxxx';
    # return {“isPosted”: “true”}
    #
    def user_set_password_by_admin!(userId, password)
      parameter = {:userid => userId, :action => 'set'}
      api_client('raas/v1/user/password', parameter, {:password => password});
    end

    def user_set_password_by_admin(userId, password)
      user_set_password_by_admin!(userId, password)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to authenticate users and returns the profile data associated with the authenticated user.
    #
    # username = 'username';//email id
    # password = 'xxxxxxxxxx';
    #
    # return all user profile
    #
    def user_authentication!(username, password)
      api_client('raas/v1/user', {:username => username, :password => password});
    end

    def user_authentication(username, password)
      user_authentication!(username, password)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API retrieves the profile data associated with the specific user using the users unique UserID
    #
    # userId = 'xxxxxxxxxx';
    #
    # return all user profile
    #
    def user_get_profile_by_id!(userId)
      api_client('raas/v1/user', {:userid => userId});
    end

    def user_get_profile_by_id(userId)
      user_get_profile_by_id!(userId)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API retrieves the profile data associated with the specific user using the users unique Email Address
    #
    # email = 'xxxxxxxxxx@xxxxxxxx.xxx';
    #
    # return all user profile
    #
    def user_get_profile_by_email!(email)
      api_client('raas/v1/user', {:emailid => email});
    end

    def user_get_profile_by_email(email)
      user_get_profile_by_email!(email)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to block or un-block a user using the users unique UserID (UID).
    #
    # uid = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    # action = true/false(boolean)
    #
    # return all user profile
    #/
    def user_set_status!(uid, action)
      api_client('raas/v1/user/status', {:accountid => uid}, {:isblock => action});
    end

    def user_set_status(uid, action = true)
      user_set_status!(uid, action)
    rescue LoginRadiusRaas::Exception => e
      false
      end

  end
end
