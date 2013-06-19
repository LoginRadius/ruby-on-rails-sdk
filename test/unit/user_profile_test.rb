require_relative 'base_test.rb'
class UserProfileTest < BaseTest
  TOKEN = "yourtoken"
  SECRET = "yoursecret"
  
  def setup
    @user_profile = LoginRadius::UserProfile.new({
      :token => TOKEN,
      :secret => SECRET,
      :async => false
    })
    @user_profile.login
  end
  
  test "basic user profile login sync" do
    assert_not_nil(@user_profile.id)
    assert_not_nil(@user_profile.provider)
    assert(@user_profile.authenticated?)
  end
  
  test "mentions" do
    assert(@user_profile.twitter_mentions.is_a?(Array))
  end
  
  test "timeline" do
    assert(@user_profile.twitter_timeline.is_a?(Array))
  end
  
  test "companies" do
    assert(@user_profile.linked_in_companies.is_a?(Array))
  end
  
  test "contacts" do
    assert(@user_profile.contacts.is_a?(Array))
  end
  
  test "groups" do    
    assert(@user_profile.facebook_groups.is_a?(Array))
  end
  
  test "posts" do    
    assert(@user_profile.facebook_posts.is_a?(Array))
  end
  
  test "events" do    
    assert(@user_profile.facebook_events.is_a?(Array))
  end
  
  test "fb post" do
    params = {
      :title => "Testing",
      :url => "www.loginradius.com",
      :status => "Wizzup",
      :caption => "Testly",
      :description => "Testing"
    }
    assert(@user_profile.make_facebook_post(params))
  end
  
  test "twitter message" do
    assert(@user_profile.send_twitter_message(@user_profile.contacts.first[:id], "Testing", "This is a test."))
  end
  
  test "linked in message" do
    assert(@user_profile.send_linked_in_message(@user_profile.contacts.first[:id], "Testing", "This is a test."))
  end
  
end
