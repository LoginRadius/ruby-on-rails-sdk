module TestConfig
  # Create fanv_file in /tests with environment variables configured in this format: 
  # NAME1=value1
  # NAME2=value2
  # The next three lines will load the credentials
  File.readlines("env_file").each do |line|
    values = line.split("=")
    ENV[values[0]] = values[1]
  end

  CREDENTIALS = {
   site_name: ENV['SITE_NAME'],
   api_key: ENV['API_KEY'],
   api_secret: ENV["API_SECRET"]
  }

  SECURITY_QUESTION_ID = ENV['SECURITY_QUESTION_OD']
  CUSTOM_REGISTRATION_DATA_TYPE = ENV['CUSTOM_REGISTRATION_DATA_TYPE'] # Warning: Only use a registration data type that is either empty or for sole testing use as data may be unexpectedly deleted.
  CUSTOM_OBJECT_NAME = ENV['CUSTOM_REGISTRATION_DATA_TYPE']

  SOCIAL_LOGIN_REQUEST_TOKEN = ENV['SOCIAL_LOGIN_REQUEST_TOKEN']
  FACEBOOK_ACCESS_TOKEN = ENV['FACEBOOK_ACCESS_TOKEN']
  TWITTER_ACCESS_TOKEN = ENV["TWITTER_ACCESS_TOKEN"] # Warning: SocialTests will attempt to post messages using the Twitter access tokens
  TWITTER_TOKEN_SECRET = ENV["TWITTER_TOKEN_SECRET"]
  VKONTAKTE_ACCESS_TOKEN = ENV["VKONTAKTE_ACCESS_TOKEN"]
  GOOGLE_JWT_TOKEN = ENV["GOOGLE_JWT_TOKEN"]
end