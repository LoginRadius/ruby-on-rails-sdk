module Api
  class RegistrationController < ApplicationController
    def registration
      verification_url = params[:"verification_url"]
      data = params[:registration]
      email_template = ''
      fields = ''
      welcome_email_template = ''

      sott = AuthenticationApi.local_generate_sott(10)
      # p sott
      response = AuthenticationApi.user_registration_by_email(data, sott, email_template, fields, verification_url, welcome_email_template)

      render :status => response.code, :json => response.body
    end

    def registration_verify_email
      verification_token = params[:"verification_token"]

      fields = ''
      url = ''
      welcome_email_template = ''

      response = AuthenticationApi.verify_email(verification_token, fields, url, welcome_email_template)

      render :status => response.code, :json => response.body
    end
  end
end
