module Api
  class LoginController < ApplicationController
	
  def email_login
      verification_url = params[:"verification_url"]
      body = params[:login]
      response = AuthenticationApi.login_by_email(body, '', '', '', verification_url)	

      render :status => response.code, :json => response.body
    end

    def accountProfileByEmail
        fields = ''
        response= AuthenticationApi.account_profile_by_email("test55@mailazy.com", fields); 

      render :status => response.code, :json => response.body
    end

    def forgot_password
      reset_password_url = params[:"reset_password_url"]
      email = params[:Email]

      response = AuthenticationApi.forgot_password(email, reset_password_url, '')

      render :status => response.code, :json => response.body
    end

    def passwordless_login
      verification_url = params[:"verification_url"]
      password_less_login_template = ''
      response = PasswordLessLoginApi.passwordless_login_by_email(params[:email], password_less_login_template, verification_url)

      render :status => response.code, :json => response.body
    end

    def passwordless_auth
      verification_token = params[:"verification_token"]
      fields = ''
      welcome_email_template = ''
      response = PasswordLessLoginApi.passwordless_login_verification(verification_token, fields, welcome_email_template)

      render :status => response.code, :json => response.body
    end

    def reset_password_by_reset_token
      reset_token = params[:"resettoken"]
      new_password = params[:"password"]

      reset_password_model_with_lockout = {
        'resettoken': reset_token,
        'password': new_password,
        'welcomeEmailTemplate': '',
        'resetPasswordEmailTemplate': ''
      }
      response = AuthenticationApi.reset_password_by_reset_token(reset_password_model_with_lockout)

      render :status => response.code, :json => response.body
    end
  end
end
