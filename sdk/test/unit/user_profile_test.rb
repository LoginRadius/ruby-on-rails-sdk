require_relative 'base_test.rb'
class UserProfileTest < BaseTest
  TOKEN = "8f3e154f-fa1f-4e4d-9c83-d5e9e84e052e"
  SECRET = "8e391ca0-54df-4ac3-8c6d-884080f9305e"
  
  def setup
    @user_profile = LoginRadius::UserProfile.new({
      :token => TOKEN,
      :secret => SECRET,
      :async => false
    })
    @user_profile.access_token
  end

  test "basic user profile login sync" do
    assert(@user_profile.userprofile.is_a?(Array))
  end
  
  test "event" do
    assert(@user_profile.event.is_a?(Array))
  end
  
  test "mention" do
    assert(@user_profile.mention.is_a?(Array))
  end
  
  test "company" do
    assert(@user_profile.company.is_a?(Array))
  end
  
  test "group" do
    assert(@user_profile.group.is_a?(Array))
  end
  
  test "post" do    
    assert(@user_profile.post.is_a?(Array))
  end
  
  test "status" do    
    assert(@user_profile.status.is_a?(Array))
  end
  
  test "following" do    
    assert(@user_profile.following.is_a?(Array))
  end
  test "album" do    
    assert(@user_profile.album.is_a?(Array))
  end
  test "checkin" do    
    assert(@user_profile.checkin.is_a?(Array))
  end
  test "like" do    
    assert(@user_profile.like.is_a?(Array))
  end
  test "audio" do    
    assert(@user_profile.audio.is_a?(Array))
  end
  test "video" do    
    assert(@user_profile.video.is_a?(Array))
  end
  
  test "post_status" do
    params = {
      :access_token => :access_token,
      :title => "loginradius title for testing",
      :url => "https://www.loginradius.com",
      :status => "loginradius status for testing",
      :caption => "loginradius caption for testing",
      :description => "loginradius description for testing"
    }
    assert(@user_profile.post_status(params))
  end
  
  test "direct_message" do
    params = {
      :access_token => :access_token,
      :to => @user_profile.contacts.first[:id],
      :subject => "loginradius subject for testing",
      :message => "loginradius message for testing"
    }
    assert(@user_profile.direct_message(params))
  end  
end
