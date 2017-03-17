class Event < ApplicationRecord
	has_many :attendees
	has_many :event_groupships
	has_many :groups, through: :event_groupships 
	belongs_to :category, optional: true
	belongs_to :user

	delegate :name, :to => :category, :prefix => true, :allow_nil => true

	def self.latest(number)
		order("created_at desc").limit(number)
	end
end
