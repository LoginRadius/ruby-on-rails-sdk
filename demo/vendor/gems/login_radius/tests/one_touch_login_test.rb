require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class OneTouchLoginTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the OneTouchLogin class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@one_touch_api = LoginRadius::OneTouchLogin.new(CREDENTIALS)

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
  
  def test_one_touch_login_by_email
    data = {
      "email" => @@tester_email,
      "name" => @@tester_username,
      "clientguid" => "testguid" + rand(1000).to_s,
      "g-recaptcha-response" => "abcd"
    }
    result = @@one_touch_api.one_touch_login_by_email(data)
    assert_equal("403", result.code, result.body)
    assert_equal("CAPTCHA is invalid", result.body[:Message])
  end

  def test_one_touch_login_by_phone
    data = {
      "phone" => @@tester_phoneid,
      "g-recaptcha-response" => "abcd"
    }
    result = @@one_touch_api.one_touch_login_by_phone(data)
    assert_equal("403", result.code, result.body)
    assert_equal("CAPTCHA is invalid", result.body[:Message])
  end

  def test_one_touch_login_verify_by_otp
    result = @@one_touch_api.one_touch_otp_verification("99999", "12016768877")
    assert_equal("403", result.code, result.body)
    assert_equal("Invalid OTP Code", result.body[:Message])
  end

  def test_one_touch_login_verify_otp_by_email
    result = @@one_touch_api.one_touch_email_verification("abc")
    assert_equal("403", result.code, result.body)
    assert_equal("Verification token (vtoken) is invalid", result.body[:Message])
  end
end
