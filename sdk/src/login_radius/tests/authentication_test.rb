require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class AuthenticationTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the Authentication class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@authentication_api = LoginRadius::Authentication.new(CREDENTIALS)
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
      "EmailVerified" => true
    }
    result = @@account_api.account_create(data)
    @tester_uid = result.body[:Uid]
    @tester_email = result.body[:Email][0][:Value]
    @tester_username = result.body[:UserName]
    @tester_phoneid = result.body[:PhoneId]

    login_data = {
      "email" => @tester_email,
      "password" => "password"
    }
    result_login = @@authentication_api.login_by_email("", "", login_data)
    @tester_access_token = result_login.body[:access_token]
  end

  def teardown
    @@account_api.account_delete(@tester_uid)
  end

  def test_add_email
    result = @@authentication_api.add_email(@tester_access_token, "rubyunittester100secondary@mailinator.com", "Secondary")
    assert_equal("200", result.code)
  end

  def test_forgot_password
    result = @@authentication_api.forgot_password("www.example.com", @tester_email)
    assert_equal("200", result.code)
  end

  def test_user_registration_by_email
    timestamp = Time.now.to_i.to_s
    registration_data = {
      "Email": [
        {
          "Type": "Primary",
          "Value": "lrrubytest" + timestamp + "@mailinator.com"
        }
      ],
      "Password": "password"
    }
    result = @@authentication_api.user_registration_by_email(registration_data)
    assert_equal("200", result.code)

    new_user = @@account_api.account_profiles_by_email("lrrubytest" + timestamp + "@mailinator.com")
    @@account_api.account_delete(new_user.body[:Uid])
  end

  def test_login_by_email
    assert_not_nil(@tester_access_token)
  end

  def test_login_by_username
    result = @@authentication_api.login_by_username(@tester_username, "password")
    assert_equal("200", result.code, result.body)
  end

  def test_check_email_availability
    result = @@authentication_api.check_email_availability(@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_check_username_availability
    result = @@authentication_api.check_username_availability(@tester_username)
    assert_equal("200", result.code, result.body)
  end

  def test_read_profiles_by_access_token
    result = @@authentication_api.read_profiles_by_access_token(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_privacy_policy_accept
    result = @@authentication_api.privacy_policy_accept(@tester_access_token)
    assert_equal("403", result.code)
    assert_equal("Privacy policy is not available", result.body[:Message], result.body)
  end

  def test_send_welcome_email
    result = @@authentication_api.send_welcome_email(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_social_identity
    result = @@authentication_api.social_identity(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_validate_access_token
    result = @@authentication_api.validate_access_token(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end 

  def test_verify_email
    data = {
      "EmailVerified" => false
    }
    @@account_api.account_update(@tester_uid, data)
    v_token = @@account_api.email_verification_token(@tester_email).body[:VerificationToken]
    result = @@authentication_api.verify_email(v_token)
    assert_equal("200", result.code, result.body)
  end

  def test_verify_email_by_otp
    result = @@authentication_api.verify_email_by_otp(@tester_email, "99999")
    assert_equal("403", result.code)
    assert_equal("Invalid email verification OTP", result.body[:Message], result.body)
  end

  def test_delete_account
    result = @@authentication_api.delete_account("9999999999999")
    assert_equal("403", result.code)
    assert_equal("The LoginRadius DeleteToken is invalid", result.body[:Message], result.body)
  end

  def test_invalidate_access_token
    result = @@authentication_api.invalidate_access_token(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_auth_security_questions_by_access_token
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_auth_security_questions_by_access_token")
    else
      data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "Answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, data)
      result = @@authentication_api.get_security_questions_by_access_token(@tester_access_token)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_auth_security_questions_by_email
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_auth_security_questions_by_email")
    else
      data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "Answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, data)
      result = @@authentication_api.get_security_questions_by_email(@tester_email)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_auth_security_questions_by_username
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_auth_security_questions_by_username")
    else
      data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "Answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, data)
      result = @@authentication_api.get_security_questions_by_username(@tester_username)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_auth_security_questions_by_phone
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_auth_security_questions_by_phone")
    else
      data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "Answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, data)
      result = @@authentication_api.get_security_questions_by_phone(@tester_phoneid)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_change_password
    result = @@authentication_api.change_password(@tester_access_token, "password", "passwords")
    assert_equal("200", result.code, result.body)
  end

  def test_resend_email_verification
    data = {
      "EmailVerified" => false
    }
    @@account_api.account_update(@tester_uid, data)
    result = @@authentication_api.resend_email_verification(@tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_reset_password_by_reset_token
    reset_token = @@account_api.forgot_password_token(@tester_email).body[:ForgotToken]
    result = @@authentication_api.reset_password_by_reset_token(reset_token, "passwords")
    assert_equal("200", result.code, result.body)
  end

  def test_reset_password_by_otp
    result = @@authentication_api.reset_password_by_otp("99999", @tester_email, "passwords")
    assert_equal("403", result.code)
    assert_equal("Verification OTP is invalid", result.body[:Message])
  end

  def test_reset_password_by_security_answer_and_email
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_reset_password_by_security_answer_and_email")
    else
      sq_data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, sq_data)

      data = {
        "securityanswer" => {
          SECURITY_QUESTION_ID => "answer"
        },
        "email" => @tester_email,
        "password" => "passwords"
      }
      result = @@authentication_api.reset_password_by_security_answer_and_email(data)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_reset_password_by_security_answer_and_phone
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_reset_password_by_security_answer_and_phone")
    else
      sq_data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, sq_data)

      data = {
        "securityanswer" => {
          SECURITY_QUESTION_ID => "answer"
        },
        "phone" => @tester_phoneid,
        "password" => "passwords"
      }
      result = @@authentication_api.reset_password_by_security_answer_and_phone(data)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_reset_password_by_security_answer_and_username
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_reset_password_by_security_answer_and_username")
    else
      sq_data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "answer"
        }
      }
      @@authentication_api.update_security_questions_by_access_token(@tester_access_token, sq_data)

      data = {
        "securityanswer" => {
          SECURITY_QUESTION_ID => "answer"
        },
        "username" => @tester_username,
        "password" => "passwords"
      }
      result = @@authentication_api.reset_password_by_security_answer_and_username(data)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_auth_set_or_change_username
    result = @@authentication_api.set_or_change_username(@tester_access_token, "rutester100")
    assert_equal("200", result.code, result.body)
  end

  def test_update_profile_by_access_token
    data = {
      "Gender" => "M"
    }
    result = @@authentication_api.update_profile_by_access_token(@tester_access_token, data)
    assert_equal("200", result.code, result.body)
  end

  def test_auth_update_security_question_by_access_token
    if (SECURITY_QUESTION_ID == "")
      puts("Security Question ID needs to be defined in config.rb for test_auth_update_security_question_by_access_token")
    else
      data = {
        "securityquestionanswer" => {
          SECURITY_QUESTION_ID => "answer"
        }
      }
      result = @@authentication_api.update_security_questions_by_access_token(@tester_access_token, data)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_delete_account_with_email_confirmation
    result = @@authentication_api.delete_account_with_email_confirmation(@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_remove_email
    result = @@authentication_api.remove_email(@tester_access_token, @tester_email)
    assert_equal("200", result.code, result.body)
  end

  def test_link_unlink_social_identities
    if (SOCIAL_LOGIN_REQUEST_TOKEN == "")
      puts("Social Login Request Token needs to be defined in config.rb for test_auth_link_unlink_social_identities")
    else
      linkResult = @@authentication_api.link_social_identities(@tester_access_token, SOCIAL_LOGIN_REQUEST_TOKEN)
      assert_equal("200", linkResult.code, linkResult.body)

      tester_profile = @@account_api.account_profiles_by_email(@tester_email)
      account_provider = tester_profile.body[:Identities][0][:Provider]
      account_provider_id = tester_profile.body[:Identities][0][:ID]

      unlinkResult = @@authentication_api.unlink_social_identities(@tester_access_token, account_provider, account_provider_id)
      assert_equal("200", unlinkResult.code, unlinkResult.body)
    end
  end
end
