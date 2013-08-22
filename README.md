Description
===============

Application used to support a Campus Codefest. Events which are not quite hackathons, not quite educational but fall 
somewhere in between. The concept of a Campus Codefest originated at the University of Minnesota, Twin Cities in 2013.
Some of the environmental challenges at the University included decentralized IT function, lack of paid time developing
practical applications and ideas with cross cutting concerns. 

A Campus Codefest requires bottom up actions to succeed. Projects forced with a top down management method will be
destined to fail. Instead, community members are charged to organically propose projects, vote on the usefullness and
willingness to contribute to the projects which ultimately drive the Codefest itself.

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
git clone git@github.com:pete2786/campus_codefest.git
```

Bundling will take a LONG time as I require therubyracer to compile less. If you are using RVM, I recommend isolating
the gems by creating a gemset (%rvm gemset create ccf)
```
cd campus_codefest
bundle
```

Set-up your development data base, I am using mysql locally but included an example SQLite DB config for lowest overhead
```
mv config/database.yml.example config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate
```

This is a Test-Driven Development project. Your code should be speced and covered with rspec and capybara. Create a
failing test then implement the code to make it pass for models. Feature tests should be created with capybara.
```
bundle exec rspec
```

Firing up the server, then browse to http://localhost:3000
```
rails s
```

Estimated Development Cycles
===============
**Phase One**
- Improve Project idea submission, rating and voting process.
- Shibboleth Authentication
- User (University identity)
- Administration/Moderation
- Project idea Submission
- Project comments
- Project rating
- Project volunteer

**Phase Two**
- Automate project selection process
- Support project merging
- Automate creation of project repositories in University GitHub Instance
- ???

**Phase Three**
- Profit

Project Entities
===============
- Project Idea
 - :event_id
 - :title
 - :description
- Volunteer
 - :project_id
 - :user_id
- Rating
 - :user_id
 - :project_id
 - :rating
- Comment
 - :user_id
 - :project_id
 - :title
 - :comment
- User
 - :x500_id
 - :name
 - :department
 - :role
 - :admin
- Event
 - :title
 - :voting_end_date
 - :start_date
 - :end_date
 - :logo
