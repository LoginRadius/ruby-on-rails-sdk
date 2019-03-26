require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class SocialLoginTest < Test::Unit::TestCase
  # Test suite to valdiate API wrapper endpoints for the SocialLogin class
  include TestConfig

  def self.startup
    @@social_api = LoginRadius::SocialLogin.new(CREDENTIALS)
    @@token_management_api = LoginRadius::TokenManagement.new(CREDENTIALS)
  end

  def test_post_message
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_post_message.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.post_message(access_token_twitter, "991413461560131585", "Test Message", "This is a test message.")
      assert_equal("200", result.code, result.body)
    end
  end

  def test_status_posting_post
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_status_posting_post.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.status_posting_post(access_token_twitter, "Test Post", "www.test.com", "www.test.com", "This is a test post. -" + rand(10000).to_s, "A post.", "A post.")
      assert_equal("200", result.code, result.body)
    end
  end

  def test_access_token_translate
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_access_token_translate.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.translate_access_token(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_access_token_validate
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_access_token_validate.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.validate_access_token(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_access_token_invalidate
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_access_token_invalidate.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.invalidate_access_token(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_album
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_album.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_albums(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_audio
    # Using Vkontakte
    if (VKONTAKTE_ACCESS_TOKEN == "")
      puts("Vkontakte Access Token needs to be defined in config.rb for test_get_audio.")
    else
      access_token_vkontakte = @@token_management_api.access_token_via_vkontakte_token(VKONTAKTE_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_audio(access_token_vkontakte)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_checkins
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_checkins.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_checkins(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_companies
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_companies.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_checkins(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_contacts
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_get_contacts.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.get_contacts(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_events
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_events.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_events(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_following
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_get_following.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.get_following(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_groups
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_groups.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_groups(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_likes
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_likes.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_likes(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_mentions
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_get_mentions.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.get_mentions(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_message
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_get_message.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.get_message(access_token_twitter, "991413461560131585", "Test Message", "This is a test message.")
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_page
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_page.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_page(access_token_facebook, "loginradius")
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_photos
    # Using Vkontakte
    if (VKONTAKTE_ACCESS_TOKEN == "")
      puts("Vkontakte Access Token needs to be defined in config.rb for test_get_photos.")
    else
      access_token_vkontakte = @@token_management_api.access_token_via_vkontakte_token(VKONTAKTE_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_photos(access_token_vkontakte, "1")
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_posts
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_posts.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_posts(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_status_fetching
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_status_fetching.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.get_statuses(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_status_posting_get
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_status_posting_get.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.status_posting_get(access_token_twitter, "Test Post", "www.test.com", "www.test.com", "This is a test post. -" + rand(10000).to_s, "A post.", "A post.")
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_user_profile
    # Using Twitter
    if (TWITTER_ACCESS_TOKEN == "" || TWITTER_TOKEN_SECRET == "")
      puts("Twitter Access Token and Token Secret needs to be defined in config.rb for test_get_user_profile.")
    else
      access_token_twitter = @@token_management_api.access_token_via_twitter_token(TWITTER_ACCESS_TOKEN, TWITTER_TOKEN_SECRET).body[:access_token]
      result = @@social_api.user_profile(access_token_twitter)
      assert_equal("200", result.code, result.body)
    end
  end

  def test_get_videos
    # Using Facebook
    if (FACEBOOK_ACCESS_TOKEN == "")
      puts("Facebook Access Token needs to be defined in config.rb for test_get_videos.")
    else
      access_token_facebook = @@token_management_api.access_token_via_facebook_token(FACEBOOK_ACCESS_TOKEN).body[:access_token]
      result = @@social_api.get_videos(access_token_facebook)
      assert_equal("200", result.code, result.body)
    end
  end
end
