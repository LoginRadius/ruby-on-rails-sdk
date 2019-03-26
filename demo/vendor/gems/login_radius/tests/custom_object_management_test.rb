require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class CustomObjectManagementTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the CustomObjectManagement class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@custom_object_api = LoginRadius::CustomObjectManagement.new(CREDENTIALS)

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
      "Password" => "password",
      "EmailVerified" => true
    }

    result = @@account_api.account_create(data)
    @@tester_uid = result.body[:Uid]
    @@tester_access_token = @@account_api.user_impersonation(@@tester_uid).body[:access_token]
  end

  def self.shutdown
    @@account_api.account_delete(@@tester_uid)
  end

  def test_custom_object_management
    if (CUSTOM_OBJECT_NAME == "")
      puts("Custom Object Name needs to be defined in config.rb for test_custom_object_management")
    else
      create_data1 = {
        "testKey1" => "testValue1"
      }
      create_data2 = {
        "testKey2" => "testValue2"
      }
      update_data1 = {
        "testKey12" => "testValue12"
      }
      update_data2 = {
        "testKey22" => "testValue22"
      }

      # Create Custom Object by UID
      create_by_uid_result = @@custom_object_api.create_custom_object_by_uid(@@tester_uid, CUSTOM_OBJECT_NAME, create_data1)
      assert_equal("200", create_by_uid_result.code, create_by_uid_result.body)
      custom_object_id1 = create_by_uid_result.body[:Id]

      # Create Custom Object by Token
      create_by_token_result = @@custom_object_api.create_custom_object_by_access_token(@@tester_access_token, CUSTOM_OBJECT_NAME, create_data2)
      assert_equal("200", create_by_token_result.code, create_by_token_result.body)
      custom_object_id2 = create_by_token_result.body[:Id]

      # Get Custom Object by ObjectRecordId and UID
      get_by_uid_and_recordid_result = @@custom_object_api.custom_object_by_objectrecordid_and_uid(@@tester_uid, custom_object_id1, CUSTOM_OBJECT_NAME)
      assert_equal("200", get_by_uid_and_recordid_result.code, get_by_uid_and_recordid_result.body)

      # Get Custom Object by ObjectRecordId and Token
      get_by_token_and_recordid_result = @@custom_object_api.custom_object_by_objectrecordid_and_access_token(@@tester_access_token, custom_object_id2, CUSTOM_OBJECT_NAME)
      assert_equal("200", get_by_token_and_recordid_result.code, get_by_token_and_recordid_result.body)

      # Get Custom Object by Token
      get_by_token_result = @@custom_object_api.custom_object_by_access_token(@@tester_access_token, CUSTOM_OBJECT_NAME)
      assert_equal("200", get_by_token_result.code, get_by_token_result.body)

      # Get Custom Object by UID
      get_by_uid_result = @@custom_object_api.custom_object_by_uid(@@tester_uid, CUSTOM_OBJECT_NAME)
      assert_equal("200", get_by_uid_result.code, get_by_uid_result.body)

      # Update Custom Object by ObjectRecordId and UID
      update_by_uid_result = @@custom_object_api.custom_object_update_by_objectrecordid_and_uid(@@tester_uid, custom_object_id1, CUSTOM_OBJECT_NAME, "replace", update_data1)
      assert_equal("200", update_by_uid_result.code, update_by_uid_result.body)

      # Update Custom Object by ObjectRecordId and Access Token
      update_by_access_token_result = @@custom_object_api.custom_object_update_by_objectrecordid_and_access_token(@@tester_access_token, custom_object_id2, CUSTOM_OBJECT_NAME, "replace", update_data2)
      assert_equal("200", update_by_access_token_result.code, update_by_access_token_result.body)

      # Delete Custom Object by ObjectRecordId and UID
      delete_by_uid_result = @@custom_object_api.custom_object_delete_by_objectrecordid_and_uid(@@tester_uid, custom_object_id1, CUSTOM_OBJECT_NAME)
      assert_equal("200", delete_by_uid_result.code, delete_by_uid_result.body)

      # Delete Custom Object By ObjectRecordId and Token
      delete_by_token_result = @@custom_object_api.custom_object_delete_by_objectrecordid_and_access_token(@@tester_access_token, custom_object_id2, CUSTOM_OBJECT_NAME)
      assert_equal("200", delete_by_token_result.code, delete_by_token_result.body)
    end
  end
end
