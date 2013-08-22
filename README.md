Campus Codefest
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

**Project Entities**
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
