require_relative 'base_test.rb'
class UserProfileTest < BaseTest
  TOKEN = "LOGINRADIUS_API_KEY"
  SECRET = "LOGINRADIUS_SECRET_KEY"
  
  def setup
    @user_profile = LoginRadius::UserProfile.new({
      :token => TOKEN,
      :secret => SECRET,
      :async => false,
	  :ssl_verify_peer =>false #Set to true if using ssl verify certificate
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
  
  test "photo" do
    params  = {
	:access_token => @user_profile.access_token,
	:albumid => 'PASS_ALBUM_ID'
  }
    assert(@user_profile.photo(params))
  end
  
  test "page" do
    page  = {
	:access_token => @user_profile.access_token,
	:pagename => 'PASS_PAGE_NAME'
   }
    assert(@user_profile.page(params))
  end
  
  test "post_status" do
    params = {
      :access_token => :access_token,
      :title => URI.encode("LoginRadius SDK Title"),
	  :url => URI.encode("https://loginradius.com"),
	  :imageurl => URI.encode(""),
	  :status => URI.encode("LoginRadius SDK Status"),
	  :caption => URI.encode("LoginRadius SDK caption"),
	  :description => URI.encode("LoginRadius SDK description")
    }
    assert(@user_profile.post_status(params))
  end
  
  test "direct_message" do
    params = {
      :access_token => :access_token,
      :to => 'SOCIAL_FRIEND_ID',
      :subject => "LoginRadius SDK Subject",
	  :message => "LoginRadius SDK message"
    }
    assert(@user_profile.direct_message(params))
  end  
end
