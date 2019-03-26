module Api
  class LoginController < ApplicationController
    def email_login
      verification_url = params[:"verification_url"]
      body = params[:login]
      response = LoginRadiusAuthenticationClient.login_by_email("", "", body, verification_url)

      render :status => response.code, :json => response.body
    end

    def forgot_password
      reset_password_url = params[:"reset_password_url"]
      email = params[:Email]
      response = LoginRadiusAuthenticationClient.forgot_password(reset_password_url, email, "forgotpassword-default")

      render :status => response.code, :json => response.body
    end

    def passwordless_login
      verification_url = params[:"verification_url"]
      response = LoginRadiusPasswordlessClient.passwordless_login_by_email(params[:email], "oneclicksignin-default", verification_url)

      render :status => response.code, :json => response.body
    end

    def passwordless_auth
      verification_token = params[:"verification_token"]
      response = LoginRadiusPasswordlessClient.passwordless_login_verification(verification_token, "welcome-default")

      render :status => response.code, :json => response.body
    end

    def reset_password_by_reset_token
      reset_token = params[:"resettoken"]
      new_password = params[:"password"]
      response = LoginRadiusAuthenticationClient.reset_password_by_reset_token(reset_token, new_password, "welcome-default", "passwordreset-confirmation-default")

      render :status => response.code, :json => response.body
    end
  end
end
