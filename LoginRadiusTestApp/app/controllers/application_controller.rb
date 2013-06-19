class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    
  end
  
  def callback
    p params
    @user_profile = LoginRadius::UserProfile.new({
      :token => params[:token],
      :secret => "1337670d-f7fd-4066-a2e3-e440aec071ee",
      :async => false
    })
    @user_profile.login
  end
end
