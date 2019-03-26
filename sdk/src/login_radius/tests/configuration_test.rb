require_relative "../lib/login_radius"
require_relative "config"
require "test/unit"

class ConfigurationTest < Test::Unit::TestCase
  # Test suite to validate API wrapper endpoints for the Configuration class
  include TestConfig

  def self.startup
    @@configuration_api = LoginRadius::Configuration.new(CREDENTIALS)
  end

  def test_get_configurations
    result = @@configuration_api.get_configurations()
    assert_equal("200", result.code, result.body)
  end

  def test_get_server_time
    result = @@configuration_api.get_server_time()
    assert_equal("200", result.code, result.body)
  end

  def test_generate_sott
    result = @@configuration_api.generate_sott()
    assert_equal("200", result.code, result.body)
  end

  def test_get_active_sessions
    # in token_management_test.rb
  end
end
