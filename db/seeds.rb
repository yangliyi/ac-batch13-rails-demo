# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do |i|
	event = Event.create!(name: "event_"+i.to_s, descrption:"event_"+i.to_s )

	3.times do |j| 
    event.attendees.create!(name: "person_"+j.to_s)
	end

end
