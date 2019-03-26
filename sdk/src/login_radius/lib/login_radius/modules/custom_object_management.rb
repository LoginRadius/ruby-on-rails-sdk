require_relative "../request_client"

module LoginRadius
  class CustomObjectManagement
    # Ruby wrapper for the LoginRadius Custom Object Management API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2"

    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius CustomObjectManagement object with an apikey and secret
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

      raise LoginRadius::Error.new("'site_name' is a required option for CustomObjectManagement class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for CustomObjectManagement class initialization.") \
        unless self.api_key != "" && self.api_key != nil
      raise LoginRadius::Error.new("'api_secret is a required option for CustomObjectManagement class initialization.") \
        unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - Create Custom Object by UID:
    # Writes data to a custom object for a specified account by uid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/create-custom-object-by-uid
    #
    # @params uid [String]                User's unified identifier
    # @params object_name [String]        Custom object name
    # @params data [Hash]                 Hash containing custom object data
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def create_custom_object_by_uid(uid, object_name, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/" + uid + "/customobject",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # POST - Create Custom Object by Access Token:
    # Writes data to a custom object for a specified account by access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/create-custom-object-by-token
    #
    # @params access_token [String]       User's access token
    # @params object_name [String]        Custom object name
    # @params data [Hash]                 Hash containing custom object data
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def create_custom_object_by_access_token(access_token, object_name, data)
      params = {
        :apikey => self.api_key,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/customobject",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - Custom Object by ObjectRecordId and UID:
    # Retrieves Custom Object data for a specified account by object name, id, and account uid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-by-objectrecordid-and-uid
    #
    # @params uid [String]                User's unified identifier
    # @params object_record_id [String]   Custom object unique identifier
    # @params object_name [String]        Custom object name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_by_objectrecordid_and_uid(uid, object_record_id, object_name)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/" + uid + "/customobject/" + object_record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Custom Object by ObjectRecordId and Access Token:
    # Retrieves Custom Object data for a specified account by object name, id, and access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-by-objectrecordid-and-token
    #
    # @params access_token [String]       User's access token
    # @params object_record_id [String]   Custom object unique identifier
    # @params object_name [String]        Custom object name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_by_objectrecordid_and_access_token(access_token, object_record_id, object_name)
      params = {
        :apikey => self.api_key,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/customobject/" + object_record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Custom Object by Access Token:
    # Retrieves Custom Object data for a specified account by object name and access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-by-token
    # 
    # @params access_token [String]       User's access token
    # @params object_name [String]        Custom object name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_by_access_token(access_token, object_name)
      params = {
        :apikey => self.api_key,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer " + access_token
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/customobject",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Custom Object by UID:
    # Retrieves Custom Object data for a specified account by object name and account uid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-by-uid
    # 
    # @params uid [String]                User's unified identifier
    # @params object_name [String]        Custom object name
    # 
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_by_uid(uid, object_name)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/" + uid + "/customobject",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Custom Object Update by ObjectRecordId and UID:
    # Updates Custom Object data for a specified account by object name, id, and account uid.
    # If updatetype = replace, object will be replaced with new object. If updatetype = partialreplace,
    # new object will be upserted(merged).
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-update-by-objectrecordid-and-uid
    #
    # @params uid [String]                User's unified identifier
    # @params object_record_id [String]   Custom object unique identifier
    # @params object_name [String]        Custom object name
    # @params update_type [String]        replace/partialreplace
    # @params data [Hash]                 Hash containing custom object update data
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_update_by_objectrecordid_and_uid(uid, object_record_id, object_name, update_type, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :objectname => object_name,
        :updatetype => update_type
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/" + uid + "/customobject/" + object_record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Custom Object Update by ObjectRecordId and Access Token:
    # Updates Custom Object data for a specified account by object name, id, and access token.
    # If updatetype = replace, object will be replaced with new object. If updatetype = partialreplace,
    # new object will be upserted(merged).
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-update-by-objectrecordid-and-token
    #
    # @params access_token [String]       User's access token
    # @params object_record_id [String]   Custom object unique identifier
    # @params object_name [String]        Custom object name
    # @params update_type [String]        replace/partialreplace
    # @params data [Hash]                 Hash containing custom object update data
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_update_by_objectrecordid_and_access_token(access_token, object_record_id, object_name, update_type, data)
      params = {
        :apikey => self.api_key,
        :objectname => object_name,
        :updatetype => update_type
      }
      headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer " + access_token
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/customobject/" + object_record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Custom Object Delete by ObjectRecordId and UID:
    # Deletes Custom Object data from a specified account by object name, id, and account uid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-delete-by-objectrecordid-and-uid
    #
    # @params uid [String]                User's unified identifier
    # @params object_record_id [String]   Custom object unique identifier
    # @params object_name [String]        Custom object name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_delete_by_objectrecordid_and_uid(uid, object_record_id, object_name)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret,
        :objectname => object_name
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/manage/account/" + uid + "/customobject/" + object_record_id,
          "api",
          self.custom_api_domain
        ),
        params
      )
    end

    # DELETE - Custom Object Delete by ObjectRecordId and Access Token:
    # Deletes Custom Object data from a specified account by object name, id, and access token.
    # https://docs.loginradius.com/api/v2/customer-identity-api/custom-object/custom-object-delete-by-objectrecordid-and-token
    #
    # @params access_token [String]      User's access token
    # @params object_record_id [String]  Custom object unique identifier
    # @params object_name [String]       Custom object name
    #
    # @returns [LoginRadius::Response]    LoginRadius response hash
    def custom_object_delete_by_objectrecordid_and_access_token(access_token, object_record_id, object_name)
      params = {
        :apikey => self.api_key,
        :objectname => object_name
      }
      headers = {
        "Authorization" => "Bearer " + access_token
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/auth/customobject/" + object_record_id,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end
  end
end
