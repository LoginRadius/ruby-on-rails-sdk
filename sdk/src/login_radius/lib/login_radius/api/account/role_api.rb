# frozen_string_literal: true

# Created by LoginRadius Development Team
# Copyright 2025 LoginRadius Inc. All rights reserved.
require_relative '../../request_client'

module LoginRadius
  # RoleApi module
  class RoleApi
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

    # API is used to retrieve all the assigned roles of a particular User.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Roles data
    # 18.6
    def get_roles_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/role'
      get_request(resource_path, query_parameters, {})
    end

    # This API is used to assign your desired roles to a given user.
    #
    # @param account_roles_model - Model Class containing Definition of payload for Create Role API
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Complete Roles data
    # 18.7
    def assign_roles_by_uid(account_roles_model, uid)
      if account_roles_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('account_roles_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/role'
      put_request(resource_path, query_parameters, account_roles_model)
    end

    # This API is used to unassign roles from a user.
    #
    # @param account_roles_model - Model Class containing Definition of payload for Create Role API
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.8
    def unassign_roles_by_uid(account_roles_model, uid)
      if account_roles_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('account_roles_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/role'
      delete_request(resource_path, query_parameters, account_roles_model)
    end

    # This API Gets the contexts that have been configured and the associated roles and permissions.
    #
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Complete user RoleContext data
    # 18.9
    def get_role_context_by_uid(uid)
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/rolecontext'
      get_request(resource_path, query_parameters, {})
    end

    # The API is used to retrieve role context by the context name.
    #
    # @param context_name - Name of context
    #
    # @return Complete user RoleContext data
    # 18.10
    def get_role_context_by_context_name(context_name)
      if isNullOrWhiteSpace(context_name)
        raise LoginRadius::Error.new, getValidationMessage('context_name')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/rolecontext/' + context_name
      get_request(resource_path, query_parameters, {})
    end

    # This API creates a Context with a set of Roles
    #
    # @param account_role_context_model - Model Class containing Definition of RoleContext payload
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Complete user RoleContext data
    # 18.11
    def update_role_context_by_uid(account_role_context_model, uid)
      if account_role_context_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('account_role_context_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/rolecontext'
      put_request(resource_path, query_parameters, account_role_context_model)
    end

    # This API Deletes the specified Role Context
    #
    # @param context_name - Name of context
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.12
    def delete_role_context_by_uid(context_name, uid)
      if isNullOrWhiteSpace(context_name)
        raise LoginRadius::Error.new, getValidationMessage('context_name')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/rolecontext/' + context_name
      delete_request(resource_path, query_parameters, {})
    end

    # This API Deletes the specified Role from a Context.
    #
    # @param context_name - Name of context
    # @param role_context_remove_role_model - Model Class containing Definition of payload for RoleContextRemoveRole API
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.13
    def delete_roles_from_role_context_by_uid(context_name, role_context_remove_role_model, uid)
      if isNullOrWhiteSpace(context_name)
        raise LoginRadius::Error.new, getValidationMessage('context_name')
      end
      if role_context_remove_role_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('role_context_remove_role_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/rolecontext/' + context_name + '/role'
      delete_request(resource_path, query_parameters, role_context_remove_role_model)
    end

    # This API Deletes Additional Permissions from Context.
    #
    # @param context_name - Name of context
    # @param role_context_additional_permission_remove_role_model - Model Class containing Definition of payload for RoleContextAdditionalPermissionRemoveRole API
    # @param uid - UID, the unified identifier for each user account
    #
    # @return Response containing Definition of Delete Request
    # 18.14
    def delete_additional_permission_from_role_context_by_uid(context_name, role_context_additional_permission_remove_role_model, uid)
      if isNullOrWhiteSpace(context_name)
        raise LoginRadius::Error.new, getValidationMessage('context_name')
      end
      if role_context_additional_permission_remove_role_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('role_context_additional_permission_remove_role_model')
      end
      if isNullOrWhiteSpace(uid)
        raise LoginRadius::Error.new, getValidationMessage('uid')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/account/' + uid + '/rolecontext/' + context_name + '/additionalpermission'
      delete_request(resource_path, query_parameters, role_context_additional_permission_remove_role_model)
    end

    # This API retrieves the complete list of created roles with permissions of your app.
    #
    #
    # @return Complete user Roles List data
    # 41.1
    def get_roles_list()

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/role'
      get_request(resource_path, query_parameters, {})
    end

    # This API creates a role with permissions.
    #
    # @param roles_model - Model Class containing Definition of payload for Roles API
    #
    # @return Complete user Roles data
    # 41.2
    def create_roles(roles_model)
      if roles_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('roles_model')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/role'
      post_request(resource_path, query_parameters, roles_model)
    end

    # This API is used to delete the role.
    #
    # @param role - Created RoleName
    #
    # @return Response containing Definition of Delete Request
    # 41.3
    def delete_role(role)
      if isNullOrWhiteSpace(role)
        raise LoginRadius::Error.new, getValidationMessage('role')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/role/' + role
      delete_request(resource_path, query_parameters, {})
    end

    # This API is used to add permissions to a given role.
    #
    # @param permissions_model - Model Class containing Definition for PermissionsModel Property
    # @param role - Created RoleName
    #
    # @return Response containing Definition of Complete role data
    # 41.4
    def add_role_permissions(permissions_model, role)
      if permissions_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('permissions_model')
      end
      if isNullOrWhiteSpace(role)
        raise LoginRadius::Error.new, getValidationMessage('role')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/role/' + role + '/permission'
      put_request(resource_path, query_parameters, permissions_model)
    end

    # API is used to remove permissions from a role.
    #
    # @param permissions_model - Model Class containing Definition for PermissionsModel Property
    # @param role - Created RoleName
    #
    # @return Response containing Definition of Complete role data
    # 41.5
    def remove_role_permissions(permissions_model, role)
      if permissions_model.blank?
        raise LoginRadius::Error.new, getValidationMessage('permissions_model')
      end
      if isNullOrWhiteSpace(role)
        raise LoginRadius::Error.new, getValidationMessage('role')
      end

      query_parameters = {}
      query_parameters['apiKey'] = @api_key
      query_parameters['apiSecret'] = @api_secret

      resource_path = 'identity/v2/manage/role/' + role + '/permission'
      delete_request(resource_path, query_parameters, permissions_model)
    end
  end
end
