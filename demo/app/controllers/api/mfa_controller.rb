module Api
  class MfaController < ApplicationController
    def mfa_email_login
      verification_url = params[:"verification_url"]
      email = params[:Email]
      password = params[:Password]
      email_template = ''
      fields = ''
      login_url = ''
      sms_template = ''
      sms_template2_f_a = ''
      response = MultiFactorAuthenticationApi.mfa_email_login(email, password, email_template, fields, login_url, sms_template, sms_template2_f_a, verification_url)

      render :status => response.code, :json => response.body
    end

    def mfa_validate_access_token
      access_token = params[:auth]
      response = MultiFactorAuthenticationApi.mfa_configure_by_access_token(access_token,'')

      render :status => response.code, :json => response.body
    end

    def mfa_auth_google
      second_factor_authentication_token = params[:"multi_factor_auth_token"]
      google_authenticator_code = params[:googleauthenticatorcode]
      fields = ''
      sms_template2_f_a = ''

      response = MultiFactorAuthenticationApi.mfa_validate_google_auth_code(google_authenticator_code, second_factor_authentication_token, fields, sms_template2_f_a)

      render :status => response.code, :json => response.body
    end

    def mfa_enable_google_by_access_token
      access_token = params[:auth]
      two_factor_auth_model_by_google_authenticator_code = {}
      two_factor_auth_model_by_google_authenticator_code['googleauthenticatorcode'] = params[:googleauthenticatorcode] 

      # p two_factor_auth_model_by_google_authenticator_code
      response = MultiFactorAuthenticationApi.mfa_update_by_access_token(access_token, two_factor_auth_model_by_google_authenticator_code, '', '')

      render :status => response.code, :json => response.body
    end

    def mfa_reset_google
      access_token = params[:auth]
      googleauthenticator = params[:googleauthenticator]

      response = MultiFactorAuthenticationApi.mfa_reset_google_auth_by_token(access_token,googleauthenticator)

      render :status => response.code, :json => response.body
    end
  end
end