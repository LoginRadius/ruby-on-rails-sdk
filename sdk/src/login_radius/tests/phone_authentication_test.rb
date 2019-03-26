require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class PhoneAuthenticationTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the PhoneAuthentication class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@phone_api = LoginRadius::PhoneAuthentication.new(CREDENTIALS)
  end

  def setup
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
      "EmailVerified" => true,
      "PhoneIdVerified" => true
    }
    result = @@account_api.account_create(data)
    @tester_uid = result.body[:Uid]
    @tester_phoneid = result.body[:PhoneId]

    login_data = {
      "phone" => @tester_phoneid,
      "password" => "password"
    }
    result_login = @@phone_api.phone_login("", "", login_data)
    @tester_access_token = result_login.body[:access_token]
  end

  def teardown
    @@account_api.account_delete(@tester_uid)
  end

  def test_phone_login
    assert_not_nil(@tester_access_token)
  end

  def test_phone_forgot_password_by_otp
    result = @@phone_api.phone_forgot_password_by_otp(@tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_resend_verification_otp
    update_data = {
      "PhoneIdVerified" => false
    }
    @@account_api.account_update(@tester_uid, update_data)

    result = @@phone_api.phone_resend_verification_otp(@tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_resend_verification_otp_by_token
    update_data = {
      "PhoneIdVerified" => false
    }
    @@account_api.account_update(@tester_uid, update_data)

    result = @@phone_api.phone_resend_verification_otp_by_access_token(@tester_access_token, @tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_user_registration_by_sms
    test_phone_id = "12368008106"
    register_data = {
      "Email" => [
        {
          "Type" => "Primary",
          "Value" => "rubyunittester101@mailinator.com"
        }
      ],
      "PhoneId" => test_phone_id,
      "Password" => "password",
      "EmailVerified" => true,
      "PhoneIdVerified" => true
    }
    
    result = @@phone_api.phone_user_registration_by_sms(register_data)
    assert_equal("200", result.code, result.body)

    profile_uid = @@account_api.account_profiles_by_phoneid(test_phone_id).body[:Uid]
    delete_result = @@account_api.account_delete(profile_uid)
    assert_equal("200", delete_result.code, delete_result.body)
  end

  def test_phone_number_availability
    result = @@phone_api.phone_number_availability(@tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_number_update
    test_phone_id = "12368008106"
    result = @@phone_api.phone_number_update(@tester_access_token, test_phone_id)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_reset_password_by_otp
    result = @@phone_api.phone_reset_password_by_otp(@tester_phoneid, "99999", "passwords")
    assert_equal("403", result.code, result.body)
    assert_equal("Invalid OTP Code", result.body[:Message])
  end

  def test_phone_verification_by_otp
    result = @@phone_api.phone_verification_by_otp("99999", @tester_phoneid)
    assert_equal("403", result.code, result.body)
    assert_equal("This phone number has already been confirmed", result.body[:Message])
  end

  def test_phone_verification_otp_by_token
    result = @@phone_api.phone_verification_otp_by_access_token(@tester_access_token, "99999")
    assert_equal("403", result.code, result.body)
    assert_equal("Invalid OTP Code", result.body[:Message])
  end

  def test_reset_phone_id_verification
    result = @@phone_api.reset_phone_id_verification(@tester_uid)
    assert_equal("200", result.code, result.body)
  end

  def test_remove_phone_id_by_access_token
    result = @@phone_api.remove_phone_id_by_access_token(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_send_otp
    result = @@phone_api.phone_send_otp(@tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_phone_login_using_otp
    login_data = {
      "phone" => @tester_phoneid,
      "otp" => "99999"
    }

    result1 = @@phone_api.phone_login_using_otp(@tester_phoneid, "99999")
    assert_equal("403", result1.code, result1.body)
    assert_equal("Invalid OTP Code", result1.body[:Message])

    result2 = @@phone_api.phone_login_using_otp("", "", login_data)
    assert_equal("403", result2.code, result2.body)
    assert_equal("Invalid OTP Code", result2.body[:Message])
  end
end
