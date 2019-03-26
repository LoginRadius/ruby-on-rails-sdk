require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class WebhooksTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the Webhooks class
  include TestConfig

  def self.startup
    @@webhooks_api = LoginRadius::Webhooks.new(CREDENTIALS)
  end

  def test_webhooks
    # Subscribe Webhooks
    subscribe_result = @@webhooks_api.webhook_subscribe("https://www.testrubysdk.com", "Login")
    assert_equal("200", subscribe_result.code, subscribe_result.body)

    # Webhooks Test
    test_result = @@webhooks_api.webhook_test()
    assert_equal("200", test_result.code, test_result.body)

    # Webhooks Subscribed Urls
    subscribed_urls_result = @@webhooks_api.webhook_subscribed_urls("Login")
    assert_equal("200", subscribed_urls_result.code, subscribed_urls_result.body)

    # Webhooks Unsubscribe
    unsubscribe_result = @@webhooks_api.webhook_unsubscribe("https://www.testrubysdk.com", "Login")
    assert_equal("200", unsubscribe_result.code, unsubscribe_result.body)
  end
end
