module Api
  class RegistrationController < ApplicationController
    def registration
      verification_url = params[:"verification_url"]
      data = params[:registration]
      response = LoginRadiusAuthenticationClient.user_registration_by_email(data, verification_url)

      render :status => response.code, :json => response.body
    end

    def registration_verify_email
      verification_token = params[:"verification_token"]
      response = LoginRadiusAuthenticationClient.verify_email(verification_token)

      render :status => response.code, :json => response.body
    end
  end
end
