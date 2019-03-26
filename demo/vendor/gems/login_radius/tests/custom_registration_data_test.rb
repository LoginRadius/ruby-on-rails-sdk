require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class CustomRegistrationDataTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the CustomRegistrationData class
  include TestConfig

  def self.startup
    @@custom_registration_data_api = LoginRadius::CustomRegistrationData.new(CREDENTIALS)
  end

  def test_custom_registration_data
    if (CUSTOM_REGISTRATION_DATA_TYPE == "")
      puts("Custom Registration Data Type needs to be defined in config.rb for test_custom_registration_data")
    else
      # Add Registration Data
      registration_data = {
        "Data" => [
          {
            "type" => CUSTOM_REGISTRATION_DATA_TYPE,
            "key" => "example1",
            "value" => "value1",
            "parentid" => "",
            "code" => "examplecode",
            "isactive" => true
          }
        ]
      }

      add_data_result = @@custom_registration_data_api.add_registration_data(registration_data)
      assert_equal("200", add_data_result.code, add_data_result.body)

      # Get Registration Data
      get_data_result = @@custom_registration_data_api.get_registration_data(CUSTOM_REGISTRATION_DATA_TYPE, "", "0", "50")
      assert_equal("200", get_data_result.code, get_data_result.body)

      # Auth Get Registration Data
      auth_get_data_result = @@custom_registration_data_api.auth_get_registration_data(CUSTOM_REGISTRATION_DATA_TYPE, "", "0", "50")
      assert_equal("200", auth_get_data_result.code, auth_get_data_result.body)

      last_record = get_data_result.body.last
      rd_record_id = last_record[:Id]
      rd_code = last_record[:Code]

      # Validate Code
      validate_result = @@custom_registration_data_api.validate_code(rd_record_id, rd_code)
      assert_equal("200", validate_result.code, validate_result.body)

      # Update Registration Data
      update_data = {
        "type" => CUSTOM_REGISTRATION_DATA_TYPE,
        "key" => "Key",
        "value" => "a value",
        "parentid" => "",
        "code" => rd_code,
        "isactive" => true
      }
      update_result = @@custom_registration_data_api.update_registration_data(rd_record_id, CUSTOM_REGISTRATION_DATA_TYPE, "key", "a value", true, "", rd_code)
      assert_equal("200", update_result.code, update_result.body)

      # Delete Registration Data
      delete_result = @@custom_registration_data_api.delete_registration_data(rd_record_id)
      assert_equal("200", delete_result.code, delete_result.body)
    end
  end
end
