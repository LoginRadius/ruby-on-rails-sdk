module Api
  class ProfileController < ApplicationController
    def read_profile_by_access_token
      puts "params #{params[:auth]}"
      access_token = params[:auth]
      fields = ''
      response = AuthenticationApi.get_profile_by_access_token(access_token, fields)

      render :status => response.code, :json => response.body
    end

    def account_update
      uid = params[:uid]
      data = params[:profile]
      response = AccountApi.update_account_by_uid(data, uid)

      render :status => response.code, :json => response.body
    end

    def change_password
      access_token = params[:auth]
      old_password = params[:oldpassword]
      new_password = params[:newpassword]

      response = AuthenticationApi.change_password(access_token, new_password, old_password)

      render :status => response.code, :json => response.body
    end

    def set_password
      uid = params[:uid]
      password = params[:password]

      response = AccountApi.set_account_password_by_uid(password, uid)

      render :status => response.code, :json => response.body
    end
  end
end
