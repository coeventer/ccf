Description
===============

Application used to support a Campus Codefest. Events which are not quite hackathons, not quite educational but fall
somewhere in between. The concept of a Campus Codefest originated at the University of Minnesota, Twin Cities in 2013.
Some of the environmental challenges at the University included decentralized IT function, lack of paid time developing
practical applications and ideas with cross cutting concerns.

The purpose of making this application is to make planning a Campus Codefest easier. This does not have to be a custom
built application if enough functionality can be found in a practical application. If custom code is required, the goal
is to provide this code to other organizations, likely in Higher Education, wishing to perform similiar events.

Contributing
===============

## System Requirements
- Ruby >= 2.0.0
- rubygems (or RVM, rbenv)
- Git
- NPM
- Bower
- MySQL Client Development Libraries
- SQLite Development Libaries
- ImageMagick Development Libraries

It is highly recommended that you use a Ruby version manager, such as
[RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv). If you do
use a Ruby version manager, install the version of Ruby set in .ruby-version.

### On Debian/Ubuntu

```
sudo apt-get install git npm libmysqlclient-dev libsqlite3-dev libmagickcore-6.q16-dev libmagickwand-6-headers
sudo npm install bower -g
sudo ln -s /usr/bin/nodejs /usr/bin/node
export PATH="/usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16:$PATH"
```

Note that [ImageMagick/GraphicsMagick/rmagick is a bit of a mess in 2015](https://github.com/rmagick/rmagick/issues/201).
This is why we are temporarily modifying the PATH.

## Install The Project

Clone the repository to your local dev environment.
```
git@github.com:campuscodefest/ccf.git
```

Bundling will take a LONG time as I require therubyracer to compile less. If you are using RVM, I recommend isolating
the gems by creating a gemset (%rvm gemset create ccf) then focus on it (%rvm gemset use ccf)
```
cd ccf
bundle
```

We use Omniauth to support Google account login. You must generate an OAuth 2.0 API key via Google Developer Console (https://cloud.google.com/console/project), more instructions can be found here: https://developers.google.com/ad-exchange/rtb/open-bidder/google-app-guide#step-5 . Once this is done, copy the example config.yml file and enter your api key and secret to the provider section.

Note: this application rquires a wildcard domain setting. If you simply want to set-up authentication for your local development instance of the ccf app, you simply use the domain `http://lvh.me` instead of http://localhost in your google development console. The http://lvh.me is a domain that was registered as a convenience for developers and resolves to 127.0.0.1 for all requests to http://lvh.me and subdomains thereof.

For local development, the Omniauth 'developer' provider is enabled and allows you to log in without setting up any
other provider API keys. Add `127.0.0.1 lvh.me` to `/etc/hosts` to work offline.

```
cp config/config.yml.example config/config.yml
```

Set-up your development data base, I am using mysql locally but included an example SQLite DB config for lowest overhead
```
cp config/database.yml.example config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate
```

Compile the required JavaScript assets.
```
bundle exec rake bower:install
```

This is a Test-Driven Development project. Your code should be speced and covered with rspec and capybara. Create a
failing test then implement the code to make it pass for models. Feature tests should be created with capybara.
```
bundle exec rspec
```

Firing up the server, then browse to http://lvh.me:3000
```
rails s
```

Development Plan
===============
**Phase One (completed)**
- Google Account OAuth2 (UMN has Google Apps for Education) via OmniAuth
- Event, Project, User Administration/Moderation
- Project idea Submission, voting, rating, commenting
- Event registration
- General CCF marketing/information

**Phase Two (Not planned)**
- Support project merging
- Automate creation of project repositories in University GitHub Instance
- ???

**Phase Three**
- Profit
