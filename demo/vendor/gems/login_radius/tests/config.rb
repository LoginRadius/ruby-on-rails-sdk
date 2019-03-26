module TestConfig
  # Test configuration constants defined here

  # Enter in your LoginRadius sitename, key and secret
  CREDENTIALS = {
    :site_name => "",
    :api_key => "",
    :api_secret => ""
  }

  SECURITY_QUESTION_ID = ""
  CUSTOM_REGISTRATION_DATA_TYPE = "" # Warning: Only use a registration data type that is either empty or for sole testing use as data may be unexpectedly deleted.
  CUSTOM_OBJECT_NAME = ""

  SOCIAL_LOGIN_REQUEST_TOKEN = ""
  FACEBOOK_ACCESS_TOKEN = ""
  TWITTER_ACCESS_TOKEN = "" # Warning: SocialTests will attempt to post messages using the Twitter access tokens
  TWITTER_TOKEN_SECRET = ""
  VKONTAKTE_ACCESS_TOKEN = ""
  GOOGLE_JWT_TOKEN = ""
end