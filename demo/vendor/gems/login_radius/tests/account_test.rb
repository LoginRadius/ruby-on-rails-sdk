require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class AccountTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the Account class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
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
          "Value" => "rubyunittester100secondary@mailinator.com"
        }
      ],
      "UserName" => "rut100",
      "PhoneId" => "12016768877",
      "Password" => "password"
    }
    result = @@account_api.account_create(data)
    @tester_uid = result.body[:Uid]
    @tester_email = result.body[:Email][0][:Value]
    @tester_email_secondary = result.body[:Email][1][:Value]
    @tester_username = result.body[:UserName]
    @tester_phoneid = result.body[:PhoneId]
  end

  def teardown
    @@account_api.account_delete(@tester_uid)
  end

  def test_account_create
    assert_not_nil(@tester_uid)
  end

  def test_get_email_verification_token
    result = @@account_api.email_verification_token(@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_get_forgot_password_token
    result = @@account_api.forgot_password_token(@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_account_identities_by_email
    result = @@account_api.account_identities_by_email(@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_user_impersonation
    result = @@account_api.user_impersonation(@tester_uid)
    assert_equal("200", result.code, result.body)
  end

  def test_account_password
    result = @@account_api.account_password(@tester_uid)
    assert_equal("200", result.code, result.body)
  end

  def test_account_profiles_by_email
    result = @@account_api.account_profiles_by_email(@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_account_profiles_by_username
    result = @@account_api.account_profiles_by_username(@tester_username)
    assert_equal("200", result.code, result.body)
  end

  def test_account_profiles_by_phoneid
    result = @@account_api.account_profiles_by_phoneid(@tester_phoneid)
    assert_equal("200", result.code, result.body)
  end

  def test_account_profiles_by_uid
    result = @@account_api.account_profiles_by_uid(@tester_uid)
    assert_equal("200", result.code, result.body)
  end

  def test_set_password
    result = @@account_api.account_set_password(@tester_uid, "passwords")
    assert_equal("200", result.code, result.body)
  end

  def test_account_update
    update_data = {
      "Gender" => "M"
    }

    result = @@account_api.account_update(@tester_uid, update_data)
    assert_equal("200", result.code, result.body)
  end

  def test_account_update_security_question
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_account_update_security_question")
    else
      update_data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "newanswer"
        }
      }
  
      result = @@account_api.account_update_security_question_configuration(@tester_uid, update_data)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_account_invalidate_verification_status
    update_data = {
      "EmailVerified" => true
    }
    @@account_api.account_update(@tester_uid, update_data)

    result = @@account_api.account_invalidate_verification_status(@tester_uid)
    assert_equal("200", result.code, result.body)
  end

  def test_account_email_delete
    result = @@account_api.account_email_delete(@tester_uid, @tester_email_secondary)
    assert_equal("200", result.code, result.body)
  end

  def test_account_delete
    puts("If tests are being taken down correctly, account_delete is working properly.")
  end
end
