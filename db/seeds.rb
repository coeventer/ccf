# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Adding users"
u = User.create(uid: '13900152', name: "David E. H. Peterson", admin: 1)
u1 = User.create(uid: '100006639183187', name: "Mark Amffciahcahg McDonaldsen", admin: 0)
u2 = User.create(uid: '100006654841300', name: "Richard Amffedhdack Changman", admin: 0)
User.create(uid: '100006562599731', name: "Lisa Amfefbeiigca Chengwitz", admin: 0)
User.create(uid: '100006529963539', name: "Rick Amfebiifceci Putnamsky", admin: 0)
User.create(uid: '100006629763297', name: "Betty Amffbigfcbig Occhinoson", admin: 0)
User.create(uid: '100006575016740', name: "Karen Amfegejafgdj Zamorestein", admin: 0)
User.create(uid: '100006604146016', name: "Carol Amffjdadfjaf Carrierosen", admin: 0)
User.create(uid: '100006463343694', name: "Helen Amfdfccdcfid Narayanansen", admin: 0)
User.create(uid: '100006606395761', name: "Mike Amffjfciegfa Goldmanman", admin: 0)
User.create(uid: '13966290', name: "Chad Fennell", admin: 1)

puts "Adding Event"
e = Event.create(title: "Campus Codefest - Winter 2014", start_date: "2014-01-14", end_date: "2014-01-17", 
            voting_end_date: nil, voting_enabled: true,
            volunteering_enabled: true, volunteer_end_date: nil, description: "This is the Campus Codefest for Winter 2014. It wil...",
             registration_end_dt: "2014-01-11", registration_maximum: 126)
             
puts "Adding events"
p = e.projects.create(project_owner: u, title: "Create a Campus Codefest Application", 
                      description: "I don't want to type something out again.", classification: "Develop an App")
                      
p1 = e.projects.create(project_owner: u1, title: "Bike Route Share App", description: "I dunno, just do it!", 
                      classification: "Develop an App")
                       
puts "Adding volunteers"
p.volunteer(u)
p.volunteer(u2)
p1.volunteer(u1)

puts "Adding votes"
p.toggle_vote(u)
p.toggle_vote(u1)
p.toggle_vote(u2)
p1.toggle_vote(u)
p1.toggle_vote(u2)

puts "Adding comments"
p.comments.create(user: u, description: "Seems purtty cool to me, but I proposed it.")
p1.comments.create(user: u, description: "Ain't nobody got time for that!")

puts "Adding registrants"
User.all.each do |user|
  e.registrations.create(user: user)
end