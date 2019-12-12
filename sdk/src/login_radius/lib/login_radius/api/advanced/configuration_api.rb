# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2019 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # ConfigurationApi module
  class ConfigurationApi
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
    # This API is used to get the configurations which are set in the LoginRadius Dashboard for a particular LoginRadius site/environment
    #
    # @return Response containing LoginRadius App configurations which are set in the LoginRadius Dashboard for a particular LoginRadius site/environment
    # 100
    def get_configurations()
      resource_path = 'ciam/appinfo'
      query_parameters = {}
      query_parameters['apikey'] = @api_key

      get_request(resource_path, query_parameters, nil)
    end

    # This API allows you to query your LoginRadius account for basic server information and server time information which is useful when generating an SOTT token.
    #
    # @param time_difference - The time difference you would like to pass, If you not pass difference then the default value is 10 minutes
    #
    # @return Response containing Definition of Complete service info data
    # 3.1
    def get_server_info(time_difference = '')

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      unless time_difference == false
        query_parameters['timeDifference'] = time_difference
      end

      resource_path = 'identity/v2/serverinfo'
      get_request(resource_path, query_parameters, nil)
    end
  end
end
