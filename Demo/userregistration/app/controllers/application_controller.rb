class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  include ApplicationHelper
  
  def index
    LoginRadiusConfig();
  end;

  def profile
    profilePage();
  end;

  def logout
    logoutPage();
  end;

  def callback
    callbackPage();
  end;
    
end;
