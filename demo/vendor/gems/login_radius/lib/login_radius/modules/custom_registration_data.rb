require_relative "../request_client"

module LoginRadius
  class CustomRegistrationData
    # Ruby wrapper for the LoginRadius Custom Registration Data API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2"

    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius CustomRegistrationData object with an apikey and secret
    # Takes in a hash containing site_name(required), api_key(required), api_secret(required),
    # and custom_api_domain(optional)
    def initialize(options = {
      :site_name => "",
      :api_key => "",
      :api_secret => "",
      :custom_api_domain => ""
    })
      self.site_name = options[:site_name]
      self.api_key = options[:api_key]
      self.api_secret = options[:api_secret]
      self.custom_api_domain = options[:custom_api_domain]

      raise LoginRadius::Error.new("'site_name' is a required option for CustomRegistrationData class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for CustomRegistrationData class initialization.") \
        unless self.api_key != "" && self.api_key != nil
      raise LoginRadius::Error.new("'api_secret is a required option for CustomRegistrationData class initialization.") \
        unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - Add Registration Data:
    # Adds data to your custom DropDownList configured for user registration.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/add-registration-data
    #
    # @params data [Hash]                  Hash containing registration data
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def add_registration_data(data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/registrationdata",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Validate Code:
    # Validates code for a particular dropdown member.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/validate-code
    #
    # @params record_id [String]           Dropdown member's record id
    # @params code [String]                Dropdown member's code
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def validate_code(record_id, code)
      params = {
        :apikey => self.api_key
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "recordid" => record_id,
        "code" => code
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/registrationdata/validatecode",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - Get Registration Data:
    # Retrieves dropdown data. Needs API secret.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/get-registration-data
    #
    # @params type [String]                Type of datasource
    # @params parent_id [String]           Id of parent dropdown member if any
    # @params skip [String]                Number of records to skip from the start
    # @params limit [String]               Limit of the number of records to return (max 50)
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def get_registration_data(type, parent_id = "", skip = "", limit = "")
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :parentid => parent_id,
        :skip => skip,
        :limit => limit
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/registrationdata/" + type,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Auth Get Registration Data:
    # Retrieves dropdown data. No API secret required.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/auth-get-registration-data
    #
    # @params type [String]                Type of datasource
    # @params parent_id [String]           Id of parent dropdown member if any
    # @params skip [String]                Number of records to skip from the start
    # @params limit [String]               Limit of the number of records to return (max 50)
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def auth_get_registration_data(type, parent_id = "", skip = "", limit = "")
      params = {
        :apikey => self.api_key,
        :parentid => parent_id,
        :skip => skip,
        :limit => limit
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/registrationdata/" + type,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Update Registration Data:
    # Updates a member of configured DropDownList.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/update-registration-data
    #
    # @params record_id [String]           Dropdown member's record id
    # @params type [String]                Datasource type
    # @params key [String]                 Text to display for the dropdown member
    # @params value [String]               Value of the dropdown member
    # @params is_active [Boolean]          Is member active or not
    # @params parent_id [String]            Id of parent dropdown member
    # @params code [String]                 Dropdown member's code
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def update_registration_data(record_id, type, key, value, is_active = true, parent_id = "", code = "")
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      data = {
        "IsActive" => is_active,
        "Type" => type,
        "Key" => key,
        "Value" => value,
        "ParentId" => parent_id,
        "Code" => code
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/registrationdata/" + record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Delete Registration Data:
    # Deletes a member of configured DropDownList.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/delete-registration-data
    #
    # @params record_id [String]           Dropdown member's record id
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def delete_registration_data(record_id)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }
      
      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/registrationdata/" + record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end
  end
end
