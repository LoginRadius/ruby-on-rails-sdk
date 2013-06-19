#Just a basic ruby script for testing EM-Synchrony.
#Run it in the command line: bundle exec ruby test/basic_async_test.rb
#Just does a few GETs to make sure it works in the EM environment.
require "rubygems"
require "bundler"
Bundler.require(:default, :test)
require 'em-synchrony'
require "em-synchrony/em-http"

require 'yaml'
base_dir = File.expand_path(File.join(File.dirname(__FILE__), "../"))
require base_dir + "/lib/login_radius.rb"

EM.synchrony do
  TOKEN = "2543d3b0-d3f3-480e-a320-48f297446458"
  SECRET = "1337670d-f7fd-4066-a2e3-e440aec071ee"
  
  time = Time.now
  @user_profile = LoginRadius::UserProfile.new({
    :token => TOKEN,
    :secret => SECRET,
    :async => true
  })
  
  @user_profile.login
  puts @user_profile.contacts!.first
  p "Total time async was #{Time.now - time}"

end
