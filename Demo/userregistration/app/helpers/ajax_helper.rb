module AjaxHelper
  def ajaxPage
    if(params[:func] == 'extendedProfile')
      @ProfileData = extendedProfile(params[:access_token]);
    elsif(params[:func] == 'contact')
      @ProfileData = @user_profile.get_contacts(params[:access_token]);
    elsif(params[:func] == 'likes')
      @ProfileData = @user_profile.get_likes(params[:access_token]);
    elsif(params[:func] == 'albums')
      @ProfileData = @user_profile.get_albums(params[:access_token]);
    elsif(params[:func] == 'checkins')
      @ProfileData = @user_profile.get_checkins(params[:access_token]);
    elsif(params[:func] == 'audio')
      @ProfileData = @user_profile.get_audio(params[:access_token]);
    elsif(params[:func] == 'mentions')
      @ProfileData = @user_profile.get_mentions(params[:access_token]);
    elsif(params[:func] == 'following')
      @ProfileData = @user_profile.get_following(params[:access_token]);
    elsif(params[:func] == 'events')
      @ProfileData = @user_profile.get_events(params[:access_token]);
    elsif(params[:func] == 'posts')
      @ProfileData = @user_profile.get_posts(params[:access_token]);
    elsif(params[:func] == 'companies')
      @ProfileData = @user_profile.get_followed_companies(params[:access_token]);
    elsif(params[:func] == 'groups')
      @ProfileData = @user_profile.get_groups(params[:access_token]);
    elsif(params[:func] == 'status')
      @ProfileData = @user_profile.get_status(params[:access_token]);
    elsif(params[:func] == 'photos')
      @ProfileData = @user_profile.get_photos(params[:access_token],params[:id]);
    elsif(params[:func] == 'videos')
      @ProfileData = @user_profile.get_videos(params[:access_token]);
    elsif(params[:func] == 'poststratus')
      @ProfileData = @user_profile.post_status(params[:access_token], params[:title], params[:url], params[:imageurl], params[:status], params[:title], params[:description]);
    elsif(params[:func] == 'sendmessage')
      @ProfileData = @user_profile.send_message(params[:access_token], params[:to], params[:subject], params[:message]);      
    end
  end
end
