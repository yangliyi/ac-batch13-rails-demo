namespace :fake_data do
	desc "Generate some fake data"
	task generate_events: :environment do
		5.times.each do |i|
			User.create!(
				email: Forgery('internet').email_address,
				password: Forgery('basic').password
			)
			puts "Succesfully created number #{i} user"
		end

		5.times.each do |i|
			Category.create!(name: Forgery('name').location)
			puts "Succesfully created number #{i} category"
		end

		users = User.all
		categeries = Category.all

		30.times.each do |i|
			Event.create!(
				name: Forgery('address').country,
				descrption: Forgery('lorem_ipsum').sentences,
				user: users.sample,
				category: categeries.sample,
				is_public: Forgery('basic').boolean
			)
			puts "Succesfully created number #{i} event"
		end
	end
end