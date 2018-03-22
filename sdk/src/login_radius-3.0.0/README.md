# LoginRadius

Ruby wrapper for the LoginRadius API. Get social graph information and send messages using LoginRadius'
many social network clients!

Optional Asynchronous EventMachine friendly option!

## Installation

Add this line to your application's Gemfile:

    gem 'login_radius'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install login_radius

## Usage

Take a peek:

    @LoginRadius = {
      :sitename => "<LOGINRADIUS_SITE_NAME>",
      :appkey => "<LOGINRADIUS_APPKEY>",
      :appsecret => "<LOGINRADIUS_APPSECRET>",
      :objectId => "<LOGINRADIUS_OBJECT_ID>"
    }
    @user_profile = LoginRadius::RestRequest.new(@LoginRadius);
		

### How to get a token and actually make a client

On the LoginRadius website, you are able to enter your own callback URL for your site. You will need
to setup a route on whatever framework you use, maybe "/callback." Then, get the gem forward(www.example.com)
and use it to set up a public web address for your localhost server. Then, you can enter the callback on LoginRadius
as https://example.com/callback, for instance.

Paste their example login stuff onto your index page, and then configuration provider on your LoginRadius site.

Now you're ready to go with testing!

When LoginRadius hits your callback after a user logs in, you'll see parameters like this:

Parameters: {"token"=>"yourtokenhere"}

This token is the token used in the above example. This is what you'll need to get your access token and fetch user's profile from LoginRadius.
Just paste it into the code above, and you can immediately grab their user profile on the callback,
login, and grab their contacts.
