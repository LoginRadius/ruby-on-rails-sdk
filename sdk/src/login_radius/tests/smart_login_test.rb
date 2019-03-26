require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class SmartLoginTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the SmartLogin class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@smart_login_api = LoginRadius::SmartLogin.new(CREDENTIALS)

    data = {
      "Email" => [
        {
          "Type" => "Primary",
          "Value" => "rubyunittester100@mailinator.com"
        },
        {
          "Type" => "Secondary",
          "Value" => "rubyunittester100secondary2@mailinator.com"
        }
      ],
      "UserName" => "rut100",
      "PhoneId" => "12016768877",
      "Password" => "password",
      "EmailVerified" => true
    }
    result = @@account_api.account_create(data)
    @@tester_uid = result.body[:Uid]
    @@tester_email = result.body[:Email][0][:Value]
    @@tester_username = result.body[:UserName]
  end

  def self.shutdown
    @@account_api.account_delete(@@tester_uid)
  end

  def test_smart_login_by_email_and_ping
    client_guid = "testguid" + rand(10000).to_s
    login_result = @@smart_login_api.smart_login_by_email(@@tester_email, client_guid)
    assert_equal("200", login_result.code, login_result.body)

    ping_result = @@smart_login_api.smart_login_ping(client_guid)
    assert_equal("403", ping_result.code, ping_result.body)
    assert_equal("The smart login link has not been verified", ping_result.body[:Message])
  end

  def test_smart_login_by_username
    client_guid = "testguid" + rand(10000).to_s
    result = @@smart_login_api.smart_login_by_username(@@tester_username, client_guid)
    assert_equal("200", result.code, result.body)
  end

  def test_smart_login_verify_token
    result = @@smart_login_api.smart_login_verify_token("123456789")
    assert_equal("403", result.code, result.body)
    assert_equal("Verification token (vtoken) is invalid", result.body[:Message])
  end
end
