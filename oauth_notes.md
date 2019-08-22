# Google OAuth in *Rails*

###########################################################################

1. **gems**

###########################################################################

* require gems in Gemfile

    - omniauth
    - dotenv-rails
    - omniauth-google-oauth2

```Gemfile

    ...

    gem 'omniauth'
    gem 'dotenv-rails'
    gem 'omniauth-google-oauth2'

```

* $ bundle install

Now you need a place to store your tokens (secrets)...

*NOTE*
the way Rails is progressing...
it is more secure to store these tokens (an alphanumeric string) inside of:

    - app/config/credentials.yml.enc

this can be refactored later.
the approach chosen here will utilize a .env file

#############################################################################

2. **google developers console**

#############################################################################

* login to Google Developers Console:

    - https://console.developers.google.com
    - login to your google account

* create an app in Google Developers Console:

    - click on 'select a project'
    - click on the “+” symbol to create a new project
    - name the project
    - click 'open project'

* on the left side panel:

    - click on 'Credentials'
    - click on the 'OAuth consent screen' tab to set up

* under 'Credentials' the tab:

    - click create an OAuth client ID

*NOTE*
this is where you require the client ID and client secret for your .env file

###########################################################################

3. **.env && .gitignore files**

###########################################################################

* create .env file

Make sure you run the command below inside of the root directory:

* $ touch .env

```.env

    GOOGLE_CLIENT_ID: paste_in_from_gdc
    GOOGLE_CLIENT_SECRET: paste_in_from_gdc

```

You must add this file inside of .gitignore:

    - root_dir/.gitignore

```.gitignore

    ...

    # Ignore master key for decrypting credentials and more.
    /config/master.key
    .env

```

*NOTE*
you're adding .env to the .gitignore file because websites
( in this case Github ) sometimes have protections in place which
revoke or expire tokens once they have been pushed to a repo.

to make sure this doesn't happen in your project,
you must add it to .gitignore

#############################################################################

4. **middleware**

#############################################################################

* add the middleware file to your application in:

    - $ touch config/initializers/omniauth.rb
    - add the following to omniauth.rb

```ruby

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
    end

```

*NOTE*
visit -> url:/auth/google_oauth2 to assess the google authentication

#############################################################################

5. **routes**

#############################################################################

* add oauth routes to config.routes.rb:

```ruby

    # Callback routes for Google authentication
    get 'auth/:provider/callback', to: 'sessions#google_auth'
    get 'auth/failure', to: redirect(‘/’)

```

*NOTE*
These routes manage the response after google authenticates the request.

#############################################################################

6. **controller**

#############################################################################

* add #google_auth method to sessions controller:

```ruby

    def google_auth

        # Get access tokens from the google server
        access_token = request.env["omniauth.auth"]

        user = User.from_omniauth(access_token)

        log_in(user)

        # Access_token is used to authenticate request
        # made from the rails application to the google server
        user.google_token = access_token.credentials.token

        # Refresh_token to request new access_token
        refresh_token = access_token.credentials.refresh_token

        # Note: Refresh_token is only sent once during the first request

        user.google_refresh_token = refresh_token if refresh_token.present?

        user.save

        redirect_to root_path
    end


```

*BREAKDOWN*
the #google_auth method manages the callback from Google

    - Get Access Tokens from google:

      access_token = request.env["omniauth.auth"]

    - Save Token:

      user.google_token = access_token.credentials.token

*ONLY*
save the token if you are planning to use Google APIs (Calendar, Spreadsheet.. etc)

    - Authenticate request made from rails app to google server
      && Save Refresh token if not nil:

      user.google_refresh_token = refresh_token if refresh_token.present?

*NOTE*
the refresh_token is only present for the first request.
Google assumes that you have stored the value and would not send it again.

*If you failed to save the refresh token...*
you can visit https://myaccount.google.com/permissions to remove access of your app so that google sends the refresh token again.

#############################################################################

7. **user model**

#############################################################################

* create a new user only if user email has not already existed.

```ruby
app/models/user.rb

    def self.from_omniauth(auth)

        # Creates a new user only if it doesn't exist
        where(email: auth.info.email).first_or_initialize do |user|
            user.username = auth.info.name
            user.email = auth.info.email
            user.password = SecureRandomHex(15)
        end

    end

```

*NOTE*
the #from_omniauth method returns a user object

At this point you should be able to log in using GoogleAuth
and create a new user that stores the credentials for google request authentication.
