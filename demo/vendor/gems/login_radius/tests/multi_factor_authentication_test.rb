require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class MultiFactorAuthenticationTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the MultiFactorAuthentication class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@multi_factor_api = LoginRadius::MultiFactorAuthentication.new(CREDENTIALS)
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
    @tester_email = result.body[:Email][0][:Value]
    @tester_username = result.body[:UserName]
    @tester_phoneid = result.body[:PhoneId]
  end

  def teardown
    @@account_api.account_delete(@tester_uid)
  end

  def test_mfa_email_login
    result = @@multi_factor_api.mfa_email_login(@tester_email, "password")
    assert_equal("200", result.code, result.body)
  end

  def test_mfa_username_login
    result = @@multi_factor_api.mfa_username_login(@tester_username, "password")
    assert_equal("200", result.code, result.body)
  end

  def test_mfa_phone_login
    result = @@multi_factor_api.mfa_phone_login(@tester_phoneid, "password")
    assert_equal("200", result.code, result.body)
  end

  def test_mfa_validate_access_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.mfa_validate_access_token(access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_mfa_backup_code_by_access_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.mfa_backup_codes_by_access_token(access_token)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_reset_backup_code_by_access_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.mfa_reset_backup_codes_by_access_token(access_token)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_backup_code_by_uid
    result = @@multi_factor_api.mfa_backup_codes_by_uid(@tester_uid)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_reset_backup_code_by_uid
    result = @@multi_factor_api.mfa_reset_backup_codes_by_uid(@tester_uid)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_validate_backup_code
    second_factor_auth_token = @@multi_factor_api.mfa_email_login(@tester_email, "password").body[:SecondFactorAuthentication][:SecondFactorAuthenticationToken]
    result = @@multi_factor_api.mfa_validate_backup_code(second_factor_auth_token, "99999999")
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication backup code is not configured", result.body[:Message])
  end

  def test_mfa_validate_otp
    second_factor_auth_token = @@multi_factor_api.mfa_email_login(@tester_email, "password").body[:SecondFactorAuthentication][:SecondFactorAuthenticationToken]
    otp_data = {
      "otp" => "99999"
    }

    result1 = @@multi_factor_api.mfa_validate_otp(second_factor_auth_token, "99999")
    assert_equal("403", result1.code, result1.body)
    assert_equal("Invalid OTP Code", result1.body[:Message])
    result2 = @@multi_factor_api.mfa_validate_otp(second_factor_auth_token, "", otp_data)
    assert_equal("403", result2.code, result2.body)
    assert_equal("Invalid OTP Code", result2.body[:Message])
  end

  def test_mfa_validate_google_auth_code
    second_factor_auth_token = @@multi_factor_api.mfa_email_login(@tester_email, "password").body[:SecondFactorAuthentication][:SecondFactorAuthenticationToken]
    result = @@multi_factor_api.mfa_validate_google_auth_code(second_factor_auth_token, "99999999")
    assert_equal("403", result.code, result.body)
    assert_equal("Google two factor authentication code is incorrect", result.body[:Message])
  end

  def test_mfa_update_phone_number
    second_factor_auth_token = @@multi_factor_api.mfa_email_login(@tester_email, "password").body[:SecondFactorAuthentication][:SecondFactorAuthenticationToken]
    result = @@multi_factor_api.mfa_update_phone_number(second_factor_auth_token, @tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_mfa_update_phone_number_by_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.mfa_update_phone_number_by_access_token(access_token, @tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_mfa_reset_google_authenticator_by_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.mfa_reset_google_authenticator_by_access_token(access_token)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_reset_sms_authenticator_by_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.mfa_reset_sms_authenticator_by_access_token(access_token)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_reset_google_authenticator_by_uid
    result = @@multi_factor_api.mfa_reset_google_authenticator_by_uid(@tester_uid)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_reset_sms_authenticator_by_uid
    result = @@multi_factor_api.mfa_reset_sms_authenticator_by_uid(@tester_uid)
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication client is not configured", result.body[:Message])
  end

  def test_mfa_update_by_access_token
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    result = @@multi_factor_api.update_mfa_by_access_token(access_token, "99999999")
    assert_equal("403", result.code, result.body)
    assert_equal("Two factor authentication is not enabled", result.body[:Message])
  end

  def test_mfa_update_setting
    access_token = @@account_api.user_impersonation(@tester_uid).body[:access_token]
    otp_data = {
      "otp" => "99999"
    }
    result1 = @@multi_factor_api.update_mfa_setting(access_token, "99999")
    assert_equal("403", result1.code, result1.body)
    assert_equal("Invalid OTP Code", result1.body[:Message])
    result2 = @@multi_factor_api.update_mfa_setting(access_token, "", otp_data)
    assert_equal("403", result2.code, result2.body)
    assert_equal("Invalid OTP Code", result2.body[:Message])
  end
end
