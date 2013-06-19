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
    @user_profile.login
    my_contacts = @user_profile.contacts
		
That's right, folks. It's that simple. In order to get access to LoginRadius API, you only
need to create a UserProfile object with a user's login token and your apps secret, and login.

### How to get a token and actually make a client

On the LoginRadius website, you are able to enter your own callback URL for your app. You will need
to setup a route on whatever framework you use, maybe "/callback." Then, get the gem forward(www.forwardhq.com)
and use it to set up a public web address for your localhost server. Then, you can enter the callback on LoginRadius
as https://jordanmatthew.fwd.wf/callback, for instance.

Paste their example login stuff onto your index page, and then enter your FB/Twitter credentials on their site.

Now you're ready to go with testing!

When LoginRadius hits your callback after a user logs in, you'll see parameters like this:

Parameters: {"token"=>"yourtokenhere"}

This token is the token used in the above example. This is what you'll need to get your user's profile.
Just paste it into the code above, and you can immediately grab their user profile on the callback,
login, and grab their contacts.

### Some examples

Below is just code exemplifying some of the more interesting methods and what they return.
Note if you have a user authed via facebook, and not twitter, methods like 

    @user_profile.twitter_timeline
    => false
		
Will return false, indicating you don't have access to that stream.

#### Facebook Stuff

    @user_profile.facebook_groups
    => [{:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"}]
    
    @user_profile.facebook_groups
    => [{:id=>"11111", :name=>"Name"},
     {:id=>"11111", :name=>"Name"}]
    
    
    @user_profile.facebook_events
    => [{:id=>"11111",
      :name=>"Name",
      :start_time=>"3/14/2015 9:00:00 AM",
      :rsvp_status=>"attending",
      :location=>"Across the world!"}]

And, finally, you can also make facebook posts:

    params = {
      :title => "Testing",
      :url => "www.loginradius.com",
      :status => "Wizzup",
      :caption => "Testly",
      :description => "Testing"
    }
    @user_profile.make_facebook_post(params)
    => true

Note that as of publishing, the :to option on facebook params does not work. You can't post to
other people's walls.

#### LinkedIn Stuff

To send messages over linked in:

    @user_profile.send_linked_in_message(@user_profile.contacts.first[:id], "Testing", "This is a test.")
    => true
		
Notice how I grabbed my first contact and used his :id property.

Also, you can grab a user's linked in companies:

    @user_profile.linked_in_companies
    => [{:id=>11111, :name=>"Name"}]
		
#### Twitter Stuff

To send messages over twitter:
	
    @user_profile.send_linked_in_message(@user_profile.contacts.first[:id], "Testing", "This is a test.")
    => true
	
Notice how I grabbed my first contact and used his :id property.
	
Grab your timelines and mentions:

    @user_profile.twitter_timeline
    => [{:id=>"11111",
        :text=>"Stuff",
        :date_time=>"5/20/2013 4:53:52 PM",
        :likes=>0,
        :place=>"",
        :source=>
         "<a href=\"http://twitterfeed.com\" rel=\"nofollow\">twitterfeed</a>",
        :image_url=>nil,
        :link_url=>nil,
        :name=>"Name"}]
        
    @user_profile.twitter_mentions
    => [{:id=>"11111",
        :text=>"Stuff",
        :date_time=>"3/31/2013 7:54:10 PM",
        :likes=>0,
        :place=>"",
        :source=>"web",
        :image_url=>nil,
        :link_url=>nil,
        :name=>"Name"}]
		
#### Social Network Contacts

Note this is all the contacts from every social network the user is connected to.

    @user_profile.contacts
    => [{:name=>"Name",
      :email_id=>"",
      :phone_number=>"",
      :id=>"11111",
      :profile_url=>nil,
      :image_url=>nil,
      :status=>nil,
      :industry=>nil,
      :country=>nil,
      :gender=>nil}]

#### User Profile Stuff

When you login, the API returns a hash of user profile information, which is then turned into methods
on the LoginRadius::UserProfile object for your accessing pleasure. A quick call to methods will show this. 

    @user_profile.methods
    =>[:id,
     :provider,
     :prefix,
     :first_name,
     :middle_name,
     :last_name,
     :suffix,
     :full_name,
     :nick_name,
     :profile_name,
     :birth_date,
     :gender,
     :website,
     :email,
     :country,
     ...]

Calling .methods on a user profile right after a successful login call will reveal these. 
For more information, please read the section in caveats on the matter, as it's a bit esoteric.

## Caveats

This section is for the nitpickers. It's got notes about the finer pickings of this API for those
who are wondering, but is not strictly necessary reading.

### The Bang Methods

When authenticated, a method like contacts will return 

    @user_profile.authenticated?
    => true
    @user_profile.contacts 
    => [{:name=>"Name",
      :email_id=>"",
      :phone_number=>"",
      :id=>"11111",
      :profile_url=>nil,
      :image_url=>nil,
      :status=>nil,
      :industry=>nil,
      :country=>nil,
      :gender=>nil},
      ...
		
When unauthenticated, a method like contacts will return false.

    @user_profile.authenticated?
    => false
    @user_profile.contacts
    => false

However, if you want to be a bit more flammable, try using contacts!, the bang version. It still returns
the same results when authed, but when unauthed, will actually raise a LoginRadius::Exception.
	
### The LoginRadius::UserProfile object before and after login

Once you've got a valid user_profile, you have many methods available to you. Let's quickly take a look 
at the methods in a LoginRadius::UserProfile object that hasn't yet been authenticated:

    @user_profile.authenticated?
    => false
    
    @user_profile.methods - Object.new.methods
    => [:secret,
     :secret=,
     :token,
     :token=,
     :async,
     :async=,
     :guid_valid?,
     :authenticated?,
     :call_api,
     :send_twitter_message,
     :send_linkedin_message,
     :make_facebook_post,
     :login!,
     :login,
     :twitter_mentions!,
     :twitter_mentions,
     :twitter_timeline!,
     :twitter_timeline,
     :linked_in_companies!,
     :linked_in_companies,
     :contacts!,
     :contacts,
     :facebook_groups!,
     :facebook_groups,
     :facebook_posts!,
     :facebook_posts,
     :facebook_events!,
     :facebook_events]
		
Notice we've got a lot of stuff we can access. But we're not yet authenticated. Running login and then checking
the new methods created, we see we have much more than before!
		
    @user_profile.login
    => true
    @user_profile.authenticated?
    => true
    @user_profile.methods - Object.new.methods
    => [:id,
    :provider,
    :prefix,
    :first_name,
    :middle_name,
    :last_name,
    :suffix,
    :full_name,
    :nick_name,
    :profile_name,
    :birth_date,
    :gender,
    :website,
    :email,
    :country,
    :thumbnail_image_url,
    :image_url,
    :favicon,
    :profile_url,
    :home_town,
    :state,
    :city,
    :industry,
    :about,
    :time_zone,
    :local_language,
    :language,
    :verified,
    :updated_time,
    :positions,
    :educations,
    :phone_numbers,
    :im_accounts,
    :addresses,
    :main_address,
    :created,
    :local_city,
    :profile_city,
    :local_country,
    :profile_country,
    :relationship_status,
    :quota,
    :interested_in,
    :interests,
    :religion,
    :political,
    :sports,
    :inspirational_people,
    :https_image_url,
    :followers_count,
    :friends_count,
    :is_geo_enabled,
    :total_statuses_count,
    :associations,
    :num_recommenders,
    :honors,
    :skills,
    :current_status,
    :certifications,
    :courses,
    :volunteer,
    :recommendations_received,
    :languages,
    :public_repository,
    :hireable,
    :repository_url,
    :age,
    :patents,
    :favorite_things,
    :professional_headline,
    :provider_access_credential,
    :secret,
    :secret=,
    :token,
    :token=,
    :async,
    :async=,
    :guid_valid?,
    :authenticated?,
    :call_api,
    :send_twitter_message,
    :send_linkedin_message,
    :make_facebook_post,
    :login!,
    :login,
    :twitter_mentions!,
    :twitter_mentions,
    :twitter_timeline!,
    :twitter_timeline,
    :linked_in_companies!,
    :linked_in_companies,
    :contacts!,
    :contacts,
    :facebook_groups!,
    :facebook_groups,
    :facebook_posts!,
    :facebook_posts,
    :facebook_events!,
    :facebook_events]
			
Holy moly we got a whole bunch of new methods! That's because on login, all the user profile information
returned by the API is turned into dynamically generated GETTERs on the object that you can then use later.

### Running the tests in test/unit

The base_test.rb file isn't meant to be run, it is inherited by user_profile_test.rb. In that file
you'll notice the lines at the top of the file:

    TOKEN = "yourtokenhere"
    SECRET = "yoursecrethere"

These are meant to be changed to your API secret and some user's token. What I do is I run a dummy
rails app locally and use the forward gem so that it can receive requests from the internet. Then I setup
a callback route and login page on the app and use it to have LoginRadius ping me with tokens that I can
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
this gem in evented frameworks and make sure to use apache bench to test it for nonblocking yourself.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
