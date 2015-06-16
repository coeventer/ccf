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
**Requirements**
- Ruby 1.9.3
- rubygems (or RVM, rbenv)
- Git

Clone the repository to your local dev environment.
```
git@github.com:campuscodefest/ccf.git
```

Bundling will take a LONG time as I require therubyracer to compile less. If you are using RVM, I recommend isolating
the gems by creating a gemset (%rvm gemset create ccf) then focus on it (%rvm gemset use ccf)
```
cd campus_codefest
bundle
```

Set-up your development data base, I am using mysql locally but included an example SQLite DB config for lowest overhead
```
cp config/database.yml.example config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate
```

We use Omniauth to support Google account login. You must generate an OAuth 2.0 API key via Google Developer Console (https://cloud.google.com/console/project), more instructions can be found here: https://developers.google.com/ad-exchange/rtb/open-bidder/google-app-guide#step-5 . Once this is done, copy the example config.yml file and enter your api key and secret to the provider section.
```
cp config/config.yml.example config/config.yml
```

This is a Test-Driven Development project. Your code should be speced and covered with rspec and capybara. Create a
failing test then implement the code to make it pass for models. Feature tests should be created with capybara.
```
bundle exec rspec
```

Firing up the server, then browse to http://lvh.me::3000
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
