module ApplicationHelper
  def LoginRadiusConfig
    @LoginRadius = {
      :sitename => "<LOGINRADIUS_SITE_NAME>",
      :appkey => "<LOGINRADIUS_API_KEY>",
      :appsecret => "<LOGINRADIUS_SECRET_KEY>",
      :objectId => "<LOGINRADIUS_OBJECT_ID>"
    }
    @user_profile = LoginRadiusRaas::RaasApi.new(@LoginRadius);
  end;

  def servayProfile
    param = {
      :question1 => params[:question1],
      :answer1 => params[:answer1],
      :question2 => params[:question2],
      :answer2 => params[:answer2],
      :question3 => params[:question3],
      :answer3 => params[:answer3]
    }
    survey = @user_profile.custom_object_upsert(@LoginRadius[:objectId], session[:user_profile]['Uid'], param)
    if(survey[:isPosted] != true)
      session[:message] = survey[:description];
    else
      session[:message] = 'Your survey questions saved successfully';
    end;
    session[:tab] = 'survey';
  end

  def changeProfilePassword
    if(params[:newpassword] != params[:confirmnewpassword])
      session[:message] = 'Your password do not match.';
    else
      changePassword = @user_profile.user_change_password(session[:user_profile]['Uid'],params[:oldpassword],params[:newpassword]);
      if(changePassword[:isPosted] != true)
        session[:message] = changePassword[:description];
      else
        session[:message] = 'Your account password changed successfully';
      end;
      session[:tab] = 'password';
    end;
  end

  def setProfilePassword
    if(params[:password] != params[:confirmpassword])
      session[:message] = 'Your password do not match.';
    else
      passparam = {
        :accountid => session[:user_profile]['Uid'],
        :password => params[:password],
        :emailid => session[:user_profile]['Email']
      }
      setPassword = @user_profile.user_set_password(passparam);
      if(setPassword[:isPosted] != true)
        session[:message] = setPassword[:description];
      else
        session[:message] = 'Your account password created successfully';
      end;
    end;
    session[:tab] = 'password';
  end

  def unlinkAccount
    param = {
      :accountid => session[:user_profile]['Uid'],
      :provider => params[:provider],
      :providerid => params[:providerId]
    };
    accountUnlink = @user_profile.account_unlink(param);
    if(accountUnlink[:isPosted] != true)
      session[:message] = accountUnlink[:description];
    else
      session[:message] = 'Your ' + param[:provider] + ' Account unlinked Successfully';
    end;
    session[:tab] = 'accountLink';
  end

  def updateProfile
    params[:update] = nil;
    editProfile = @user_profile.user_edit_profile(session[:user_profile]['ID'], params);
    if(editProfile[:isPosted] != true)
      session[:message] = editProfile[:description];
    else
      require 'date' 
      birthDate = ''
      if(params[:BirthDate] != nil && params[:BirthDate] != '')
        d = Date.parse(params[:BirthDate])
        birthDate = d.strftime("%d-%m-%Y")
      end;
      session[:message] = 'Your profile updated successfully';
      session[:user_profile] = {
        :Uid => session[:user_profile]['Uid'],
        :ID => session[:user_profile]['ID'],
        :Provider => session[:user_profile]['Provider'],
        :FirstName => params[:FirstName],
        :LastName => params[:LastName],
        :Email => session[:user_profile]['Email'],
        :BirthDate => birthDate,
        :Country => params[:Country],
        :City => params[:City],
        :ImageUrl => session[:user_profile]['ImageUrl']
      };
    end;
    session[:tab] = 'profile';
  end

  def accountHandler(access_token)
    @user_profile_data = extendedProfile(access_token);
    if (session[:user_profile] == "")
      accountLogin(@user_profile_data)
      session[:access_token] = access_token;
    else
      accountLinking(@user_profile_data)
    end;
  end

  def extendedProfile(access_token)
    return @user_profile.get_user_profile(access_token)
  end
    
  def accountLogin(user_profile_data)
    require 'date' 
    birthDate = ''
      if(params[:BirthDate] != nil && params[:BirthDate] != '')
        d = Date.parse(params[:BirthDate])
        birthDate = d.strftime("%d-%m-%Y")
      end;
    session[:user_profile] = {
      :Uid => user_profile_data[:Uid],
      :ID => user_profile_data[:ID],
      :Provider => user_profile_data[:Provider],
      :FirstName => user_profile_data[:FirstName],
      :LastName => user_profile_data[:LastName],
      :Email => user_profile_data[:Email][0][:Value],
      :BirthDate => birthDate,
      :Country => (user_profile_data[:Country] != nil) ? user_profile_data[:Country][:Name]:'',
      :City => user_profile_data[:City],
      :ImageUrl => user_profile_data[:ImageUrl]
    };
    session[:tab] = 'profile';
  end

  def accountLinking(user_profile_data)
    param = {
      :accountid => session[:user_profile]['Uid'],
      :provider => user_profile_data[:Provider],
      :providerid => user_profile_data[:ID]
    };

    accountLink = @user_profile.account_link(param);
    if(accountLink[:isPosted] != true)
      session[:message] = accountLink[:description];
    else
      session[:message] = 'Your ' + param[:provider] + ' Account Linked successfully';
    end;
    session[:tab] = 'accountLink';
  end
  
  def logoutPage
    if session[:user_profile] == ''
      redirect_to :action => 'index';
    else
      session[:user_profile] = '';
    end;
    LoginRadiusConfig();
  end
  
  def profilePage
    if session[:user_profile] == ''
      redirect_to :action => 'index';
    end;
    LoginRadiusConfig();
  end
  
  def callbackPage
    LoginRadiusConfig();
    if (params[:token] != nil)
      @access_token = @user_profile.get_access_token(params[:token]);
      accountHandler(@access_token[:access_token]);
    elsif ( params[:update] != nil )
      updateProfile();
    elsif (params[:value] == 'accountUnLink')
      unlinkAccount();
    elsif (params[:emailid] != nil && params[:password] != nil && params[:confirmpassword] != nil)
      setProfilePassword();
    elsif(params[:raasid] != nil && params[:oldpassword] != nil && params[:newpassword] != nil && params[:confirmnewpassword] != nil)
      changeProfilePassword();
    elsif(params[:survey] != nil)
      servayProfile();
    end;
    redirect_to :action => 'profile';
  end
end
