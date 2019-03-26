module Api
  class ProfileController < ApplicationController
    def read_profile_by_access_token
      puts "params #{params[:auth]}"
      access_token = params[:auth]
      response = LoginRadiusAuthenticationClient.read_profiles_by_access_token(access_token)

      render :status => response.code, :json => response.body
    end

    def account_update
      uid = params[:uid]
      data = params[:profile]
      response = LoginRadiusAccountClient.account_update(uid, data)

      render :status => response.code, :json => response.body
    end

    def change_password
      access_token = params[:auth]
      old_password = params[:oldpassword]
      new_password = params[:newpassword]
      response = LoginRadiusAuthenticationClient.change_password(access_token, old_password, new_password)

      render :status => response.code, :json => response.body
    end

    def set_password
      uid = params[:uid]
      password = params[:password]
      response = LoginRadiusAccountClient.account_set_password(uid, password)

      render :status => response.code, :json => response.body
    end
  end
end
