class LoginController < ApplicationController
  protect_from_forgery except: :callback
  def index
  end
  def callback
    @user_profile = LoginRadius::UserProfile.new({
      :token => params[:token],
      :secret => "SECRET-KEY-HERE",
      :async => false #Set to true if using EventMachine driven frameworks(must use Em Synchrony)
    })
    @user_profile.access_token
    @token = params[:token]
  end
end
