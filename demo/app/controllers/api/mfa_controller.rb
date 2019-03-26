module Api
  class MfaController < ApplicationController
    def mfa_email_login
      verification_url = params[:"verification_url"]
      email = params[:Email]
      password = params[:Password]
      response = LoginRadiusMultiFactorClient.mfa_email_login(email, password, "", verification_url)

      render :status => response.code, :json => response.body
    end

    def mfa_validate_access_token
      access_token = params[:auth]
      response = LoginRadiusMultiFactorClient.mfa_validate_access_token(access_token)

      render :status => response.code, :json => response.body
    end

    def mfa_auth_google
      second_factor_authentication_token = params[:"multi_factor_auth_token"]
      google_auth_code = params[:googleauthenticatorcode]
      response = LoginRadiusMultiFactorClient.mfa_validate_google_auth_code(second_factor_authentication_token, google_auth_code)

      render :status => response.code, :json => response.body
    end

    def mfa_enable_google_by_access_token
      access_token = params[:auth]
      google_auth_code = params[:googleauthenticatorcode]
      response = LoginRadiusMultiFactorClient.update_mfa_by_access_token(access_token, google_auth_code)

      render :status => response.code, :json => response.body
    end

    def mfa_reset_google
      access_token = params[:auth]
      response = LoginRadiusMultiFactorClient.mfa_reset_google_authenticator_by_access_token(access_token)

      render :status => response.code, :json => response.body
    end
  end
end