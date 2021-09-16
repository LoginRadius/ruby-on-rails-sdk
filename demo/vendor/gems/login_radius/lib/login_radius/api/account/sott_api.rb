# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # SottApi module
  class SottApi
    include RequestClient

    attr_accessor :site_name, :api_key, :api_secret

    # Initializes a LoginRadius Account object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(required)
    def initialize
      @site_name = ENV['SITE_NAME']
      @api_key = ENV['API_KEY']
      @api_secret = ENV['API_SECRET']
      raise LoginRadius::Error.new, "'site_name' is a required option for Account class initialization." \
        unless @site_name != '' && @site_name != nil
      raise LoginRadius::Error.new, "'api_key' is a required option for Account class initialization." \
        unless @api_key != '' && @api_key != nil
      raise LoginRadius::Error.new, "'api_secret is a required option for Account class initialization." \
        unless @api_secret != '' && @api_secret != nil
    end

    # This API allows you to generate SOTT with a given expiration time.
    #
    # @param time_difference - The time difference you would like to pass, If you not pass difference then the default value is 10 minutes
    #
    # @return Sott data For Registration
    # 18.28
    def generate_sott(time_difference = '')

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret
      unless time_difference == false
        query_parameters['timeDifference'] = time_difference
      end

      resource_path = 'identity/v2/manage/account/sott'
      get_request(resource_path, query_parameters, {})
    end
  end
end
