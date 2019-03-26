require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class TokenManagementTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the TokenManagement class
  include TestConfig

  def self.startup
    @@account_api = LoginRadius::Account.new(CREDENTIALS)
    @@token_api = LoginRadius::TokenManagement.new(CREDENTIALS)
    @@configuration_api = LoginRadius::Configuration.new(CREDENTIALS)

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

  def test_access_token_via_facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_access_token_via_facebook")
    else
      result = @@token_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_access_token_via_twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_access_token_via_twitter")
    else
      result = @@token_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_access_token_via_vkontakte
    if (VKONTAKTE_ACCESS_TOKEN == "")
      puts("Vkontakte Access Token needs to be defined in config.rb for test_access_token_via_vkontakte")
    else
      result = @@token_api.access_token_via_vkontakte_token(VKONTAKTE_ACCESS_TOKEN)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_access_token_via_google_jwt
    if (GOOGLE_JWT_TOKEN == "")
      puts("Google JWT Token needs to be defined in config.rb for test_access_token_via_google_jwt")
    else
      result = @@token_api.access_token_via_google_jwt(GOOGLE_JWT_TOKEN)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_refresh_user_profile
    result = @@token_api.refresh_user_profile(@@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_refresh_token
    result = @@token_api.refresh_access_token(@@tester_access_token)
    assert_equal("200", result.code, result.body)
  end

  def test_get_active_sessions
    result = @@configuration_api.get_active_session_details(@@tester_access_token)
    assert_equal("200", result.code, result.body)
  end
end
