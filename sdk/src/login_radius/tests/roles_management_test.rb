require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class RolesManagementTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the RolesManagement class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@roles_api = LoginRadius::RolesManagement.new(CREDENTIALS)

    data = {
      "Email" => [
        {
          "Type" => "Primary",
          "Value" => "rubyunittester100@mailinator.com"
        },
        {
          "Type" => "Secondary",
          "Value" => "rubyunittester100secondary@mailinator.com"
        }
      ],
      "UserName" => "rut100",
      "PhoneId" => "12016768877",
      "Password" => "password"
    }

    result = @@account_api.account_create(data)
    @@tester_uid = result.body[:Uid]
    @@tester_access_token = @@account_api.user_impersonation(@@tester_uid).body[:access_token]
  end

  def self.shutdown
    @@account_api.account_delete(@@tester_uid)
  end

  def test_roles_management
    # Create Roles
    role_data = {
      "roles" => [
        {
          "name" => "example_test_role1",
          "permissions" => {
            "pname1" => true,
            "pname2" => true
          }
        },
        {
          "name" => "example_test_role2",
          "permissions" => {
            "pname3" => true,
            "pname4" => true
          }
        }
      ]
    }

    roles_create_result = @@roles_api.roles_create(role_data)
    assert_equal("200", roles_create_result.code, roles_create_result.body)

    # Get Roles List
    roles_get_result = @@roles_api.roles_list()
    assert_equal("200", roles_get_result.code, roles_get_result.body)

    # Add Permissions to Role
    permission_data = {
      "permissions" => [
        "pname5",
        "pname6"
      ]
    }

    add_permission_result = @@roles_api.add_permissions_to_role("example_test_role2", permission_data)
    assert_equal("200", add_permission_result.code, add_permission_result.body)

    # Assign Role to User
    assign_data = {
      "roles" => [
        "example_test_role1",
        "example_test_role2"
      ]
    }

    assign_role_result = @@roles_api.assign_roles_by_uid(@@tester_uid, assign_data)
    assert_equal("200", assign_role_result.code, assign_role_result.body)

    # Get Roles by Uid
    get_roles_by_uid_result = @@roles_api.roles_by_uid(@@tester_uid)
    assert_equal("200", get_roles_by_uid_result.code, get_roles_by_uid_result.body)

    # Upsert Context
    context_data = {
      "rolecontext" => [
        {
          "context" => "example_context",
          "roles" => [
            "example_test_role1",
            "example_test_role2"
          ],
          "additionalpermissions" => [
            "eap1",
            "eap2"
          ],
          "expiration" => "2020-10-01 8:30:00 AM"
        }
      ]
    }

    upsert_context_result = @@roles_api.upsert_context(@@tester_uid, context_data)
    assert_equal("200", upsert_context_result.code, upsert_context_result.body)

    # Get Context
    get_context_result = @@roles_api.get_contexts(@@tester_uid)
    assert_equal("200", get_context_result.code, get_context_result.body)

    # Delete Additional Permissions from Context
    delete_additional_permissions_data = {
      "additionalpermissions" => [
        "eap1",
        "eap2"
      ]
    }

    delete_ap_result = @@roles_api.delete_additional_permissions_from_context(@@tester_uid, "example_context", delete_additional_permissions_data)
    assert_equal("200", delete_ap_result.code, delete_ap_result.body)

    # Delete Role from Context
    delete_role_from_context_data = {
      "roles" => [
        "example_test_role2"
      ]
    }

    delete_role_from_context_result = @@roles_api.delete_role_from_context(@@tester_uid, "example_context", delete_role_from_context_data)
    assert_equal("200", delete_role_from_context_result.code, delete_role_from_context_result.body)

    # Delete Context
    delete_context_result = @@roles_api.delete_context(@@tester_uid, "example_context")
    assert_equal("200", delete_context_result.code, delete_context_result.body)

    # Unassign Roles
    unassign_data = {
      "roles" => [
        "example_test_role2"
      ]
    }

    unassign_roles_result = @@roles_api.unassign_roles_by_uid(@@tester_uid, unassign_data)
    assert_equal("200", unassign_roles_result.code, unassign_roles_result.body)

    # Delete Permissions from Role
    delete_permission_data = {
      "permissions" => [
        "pname2"
      ]
    }

    delete_permissions_from_role_result = @@roles_api.remove_permissions_from_role("example_test_role1", delete_permission_data)
    assert_equal("200", delete_permissions_from_role_result.code, delete_permissions_from_role_result.body)

    # Delete Role
    delete_role_result1 = @@roles_api.delete_role("example_test_role1")
    delete_role_result2 = @@roles_api.delete_role("example_test_role2")
    assert_equal("200", delete_role_result1.code, delete_role_result1.body)
    assert_equal("200", delete_role_result2.code, delete_role_result2.body)
  end
end
