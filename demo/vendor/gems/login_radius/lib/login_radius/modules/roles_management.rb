require_relative "../request_client"

module LoginRadius
  class RolesManagement
    # Ruby wrapper for the LoginRadius Roles Management API module.
    include RequestClient

    BASE_RESOURCE = "/identity/v2/manage"
    
    attr_accessor :site_name, :api_key, :api_secret, :custom_api_domain

    # Initializes a LoginRadius RolesManagement object with an apikey and secret
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

      raise LoginRadius::Error.new("'site_name' is a required option for RolesManagement class initialization.") \
        unless self.site_name != "" && self.site_name != nil
      raise LoginRadius::Error.new("'api_key' is a required option for RolesManagement class initialization.") \
        unless self.api_key != "" && self.api_key != nil
      raise LoginRadius::Error.new("'api_secret is a required option for RolesManagement class initialization.") \
        unless self.api_secret != "" && self.api_secret != nil
    end

    # POST - Roles Create:
    # Creates roles with permissions.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/roles-create
    #
    # @params data [Hash]                Hash containing roles creation data
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def roles_create(data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return post_request(
        build_uri_obj(
          BASE_RESOURCE + "/role",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # GET - Get Context with Roles and Permissions:
    # Retrieves the contexts which have been configured for a user and its associated roles and permissions.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/get-context
    #
    # @params uid [String]               User's unified identifier
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def get_contexts(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/rolecontext",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Roles List:
    # Retrieves complete list of created roles with permissions of your app.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/roles-list
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def roles_list()
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/role",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # GET - Roles by UID:
    # Retrieves all assigned roles of a particular user by uid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/get-roles-by-uid
    #
    # @params uid [String]               User's unified identifier
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def roles_by_uid(uid)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return get_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/role",
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # PUT - Add Permissions to Role:
    # Adds permissions to a given role.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/add-permissions-to-role
    #
    # @params role_name [String]         Role name
    # @params data [Hash]                Hash containing role permissions data
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def add_permissions_to_role(role_name, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/role/" + role_name + "/permission",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Assign Roles by UID:
    # Assigns created roles to a user.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/assign-roles-by-uid
    #
    # @params uid [String]               User's unified identifier
    # @params data [Hash]                Hash containing role data to be added to user
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def assign_roles_by_uid(uid, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/role",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # PUT - Upsert Context:
    # Creates a context with a set of roles.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/upsert-context
    #
    # @params uid [String]               User's unified identifier
    # @params data [Hash]                Hash containing role context upsert data
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def upsert_context(uid, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return put_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/rolecontext",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end
    
    # DELETE - Delete Role:
    # Deletes a role given a role name.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-role
    #
    # @params role_name [String]         Role name
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def delete_role(role_name)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/role/" + role_name,
          "api",
          self.custom_api_domain
        ),
        params
      )
    end

    # DELETE - Unassign Roles by UID:
    # Unassigns roles from a user given uid.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/unassign-roles-by-uid
    #
    # @params uid [String]               User's unified identifier
    # @params data [Hash]                Hash containing role names to be unassigned
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def unassign_roles_by_uid(uid, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/role",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Remove Permissions:
    # Removes permissions from a role.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/remove-permissions
    #
    # @params role_name [String]         Role name
    # @params data [Hash]                Hash containing permission names to be removed
    #
    # @returns [LoginRadius::Response]   LoginRadius response hash
    def remove_permissions_from_role(role_name, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/role/" + role_name + "/permission",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Delete Role Context:
    # Deletes a specified role context given UID and role context name.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-context
    #
    # @params uid [String]                 User's unified identifier
    # @params role_context_name [String]   Role context name
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def delete_context(uid, role_context_name)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/rolecontext/" + role_context_name,
          "api",
          self.custom_api_domain
        ),
        params,
        headers
      )
    end

    # DELETE - Delete Role from Context
    # Deletes a specified role from a context.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-role-from-context
    #
    # @params uid [String]                 User's unified identifier
    # @params role_context_name [String]   Role context name
    # @params data [Hash]                  Hash containing role names to be removed from context
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash    
    def delete_role_from_context(uid, role_context_name, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/rolecontext/" + role_context_name + "/role",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end

    # DELETE - Delete Additional Permissions from Context
    # Deletes additional permissions from context.
    # https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-permissions-from-context
    #
    # @params uid [String]                 User's unified identifier
    # @params role_context_name [String]   Role context name
    # @params data [Hash]                  Hash containing additional permissions to remove from context
    #
    # @returns [LoginRadius::Response]     LoginRadius response hash
    def delete_additional_permissions_from_context(uid, role_context_name, data)
      params = {
        :apikey => self.api_key,
        :apisecret => self.api_secret
      }
      headers = {
        "Content-Type" => "application/json"
      }

      return delete_request(
        build_uri_obj(
          BASE_RESOURCE + "/account/" + uid + "/rolecontext/" + role_context_name + "/additionalpermission",
          "api",
          self.custom_api_domain
        ),
        params,
        headers,
        data
      )
    end
  end
end
