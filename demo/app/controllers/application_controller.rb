class ApplicationController < ActionController::Base
  include ApplicationHelper
   def index
    LoginRadiusConfig();
  end;
  
  def callback
    LoginRadiusConfig();
      @var=@loginradius.authReadAllProfiles(params[:token]);
      session[:AccessTokenKey] = params[:token]
      return render :json => @var
  end;
  
end
