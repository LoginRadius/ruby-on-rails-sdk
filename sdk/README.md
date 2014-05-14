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

    @user_profile = LoginRadius::UserProfile.new({
      :token => "TOKEN",
      :secret => "SECRET",
      :async => false #Set to true if using EventMachine driven frameworks(must use Em Synchrony)
    })
    @user_profile.userprofile
    my_contacts = @user_profile.contacts
		
That's right, folks. It's that simple. In order to get access to LoginRadius API, you only
need to create a UserProfile object with a user's login token and your apps secret, and login.

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

### Some examples

Below is just code exemplifying some of the more interesting methods and what they return.
Note if you have a user authored via facebook, and not twitter, methods like 

    @user_profile.event
    => false
		
Will return false, indicating you don't have access to that stream.


    @user_profile.access_token
    => [{:access_token=>"AccessToken", :expires_in=>"TokenExpireTime"}],
    
	@user_profile.companies
		=>[{:id=>"", :name=>""},
		{:id=>"", :name=>""},
		{:id=>"", :name=>""},
		{:id=>"", :name=>""}] 

	@user_profile.group
		=>[{:id=>"", :name=>"", :email=>"", :description=>"", :type=>"", :country=>"", :postal_code=>"", :logo=>"", :image=>"", :member_count=>""},
		{:id=>"", :name=>"", :email=>"", :description=>"", :type=>"", :country=>"", :postal_code=>"", :logo=>"", :image=>"", :member_count=>""},
		{:id=>"", :name=>"", :email=>"", :description=>"", :type=>"", :country=>"", :postal_code=>"", :logo=>"", :image=>"", :member_count=>""}] 

	@user_profile.post
		=>[{:id=>"", :name=>"", :title=>"", :start_time=>"", :update_time=>"", :message=>"", :place=>"", :picture=>"", :likes=>"", :share=>"", :type=>""},
		{:id=>"", :name=>"", :title=>"", :start_time=>"", :update_time=>"", :message=>"", :place=>"", :picture=>"", :likes=>"", :share=>"", :type=>""},
		{:id=>"", :name=>"", :title=>"", :start_time=>"", :update_time=>"", :message=>"", :place=>"", :picture=>"", :likes=>"", :share=>"", :type=>""},
		{:id=>"", :name=>"", :title=>"", :start_time=>"", :update_time=>"", :message=>"", :place=>"", :picture=>"", :likes=>"", :share=>"", :type=>""},
		{:id=>"", :name=>"", :title=>"", :start_time=>"", :update_time=>"", :message=>"", :place=>"", :picture=>"", :likes=>"", :share=>"", :type=>""}] 

	@user_profile.status
		=>[{:id=>"", :text=>"", :date_time=>"", :likes=>"", :place=>"", :source=>"", :image_url=>"", :link_url=>"", :name=>""},
		{:id=>"", :text=>"", :date_time=>"", :likes=>"", :place=>"", :source=>"", :image_url=>"", :link_url=>"", :name=>""},
		{:id=>"", :text=>"", :date_time=>"", :likes=>"", :place=>"", :source=>"", :image_url=>"", :link_url=>"", :name=>""},
		{:id=>"", :text=>"", :date_time=>"", :likes=>"", :place=>"", :source=>"", :image_url=>"", :link_url=>"", :name=>""},
		{:id=>"", :text=>"", :date_time=>"", :likes=>"", :place=>"", :source=>"", :image_url=>"", :link_url=>"", :name=>""}]

	@user_profile.album
		=>[{:id=>"", :owner_id=>"", :owner_name=>"", :title=>"", :description=>"", :location=>"", :type=>"", :created_date=>"", :updated_date=>"", :cover_image_url=>"", :image_count=>"", :directory_url=>},
		{:id=>"", :owner_id=>"", :owner_name=>"", :title=>"", :description=>"", :location=>"", :type=>"", :created_date=>"", :updated_date=>"", :cover_image_url=>"", :image_count=>"", :directory_url=>},
		{:id=>"", :owner_id=>"", :owner_name=>"", :title=>"", :description=>"", :location=>"", :type=>"", :created_date=>"", :updated_date=>"", :cover_image_url=>"", :image_count=>"", :directory_url=>},
		{:id=>"", :owner_id=>"", :owner_name=>"", :title=>"", :description=>"", :location=>"", :type=>"", :created_date=>"", :updated_date=>"", :cover_image_url=>"", :image_count=>"", :directory_url=>}] 

	@user_profile.like
		=>[{:id=>"", :name=>"", :category=>"", :created_date=>"", :website=>"", :description=>""},
		{:id=>"", :name=>"", :category=>"", :created_date=>"", :website=>"", :description=>""},
		{:id=>"", :name=>"", :category=>"", :created_date=>"", :website=>"", :description=>""},
		{:id=>"", :name=>"", :category=>"", :created_date=>"", :website=>"", :description=>""}]

	@user_profile.video
		=>[{:id=>"", :description=>"", :name=>"", :image=>"", :source=>"", :created_date=>"", :owner_id=>"", :owner_name=>"", :embed_html=>"", :updated_date=>"", :duration=>"", :direct_link=>""},
		{:id=>"", :description=>"", :name=>"", :image=>"", :source=>"", :created_date=>"", :owner_id=>"", :owner_name=>"", :embed_html=>"", :updated_date=>"", :duration=>"", :direct_link=>""},
		{:id=>"", :description=>"", :name=>"", :image=>"", :source=>"", :created_date=>"", :owner_id=>"", :owner_name=>"", :embed_html=>"", :updated_date=>"", :duration=>"", :direct_link=>""},
		{:id=>"", :description=>"", :name=>"", :image=>"", :source=>"", :created_date=>"", :owner_id=>"", :owner_name=>"", :embed_html=>"", :updated_date=>"", :duration=>"", :direct_link=>""}]


	
### The LoginRadius::UserProfile object before and after login

Once you've got a valid user_profile, you have many methods available to you. Let's quickly take a look 
at the methods in a LoginRadius::UserProfile object that hasn't yet been authenticated:

    @user_profile.access_token
    => false

			
Holy moly we got a whole bunch of new methods! That's because on login, all the user profile information
returned by the API is turned into dynamically generated GETTERs on the object that you can then use later.

### Running the tests in test/unit

The base_test.rb file isn't meant to be run, it is inherited by user_profile_test.rb. In that file
you'll notice the lines at the top of the file:

    TOKEN = "yourtokenhere"
    SECRET = "yoursecrethere"

These are meant to be changed to your API secret and some user's token. What I do is I run a dummy
rails site locally and use the forward gem so that it can receive requests from the internet. Then I setup
a callback route and login page on the app and use it to have LoginRadius ping me with access tokens that I can
paste into this test file.

*Beware, LoginRadius invalidates any token after 15 minutes, so during testing, you'll have to repeat the token
creation A LOT*
 
To run the tests, do:

    bundle exec ruby -Itest test/unit/user_profile_test.rb
		
If you login with a facebook user, for instance, you'll notice all the twitter/linked in tests failing.
This is to be expected, you don't have access to those streams!

### Evented Frameworks

I've built this gem to work with frameworks like Cramp. I've done a little bit of testing by creating
a basic event loop script in basic_async_test.rb in the test folder, which you can run to see that
things work there.

I've also done some AB testing using a Cramp framework elsewhere, but you should take caution in using
this gem in evented frameworks and make sure to use Apache bench to test it for non-blocking yourself.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
