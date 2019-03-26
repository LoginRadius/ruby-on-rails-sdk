require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class PasswordlessLoginTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the PasswordlessLogin class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@passwordless_api = LoginRadius::PasswordlessLogin.new(CREDENTIALS)

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
    @@tester_phoneid = result.body[:PhoneId]
  end

  def self.shutdown
    @@account_api.account_delete(@@tester_uid)
  end

  def test_passwordless_login_by_email
    result = @@passwordless_api.passwordless_login_by_email(@@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_passwordless_login_by_username
    result = @@passwordless_api.passwordless_login_by_username(@@tester_username)
    assert_equal("200", result.code, result.body)
  end

  def test_passwordless_login_verification
    result = @@passwordless_api.passwordless_login_verification("abcd")
    assert_equal("403", result.code, result.body)
    assert_equal("Verification token (vtoken) is invalid", result.body[:Message])
  end
end
