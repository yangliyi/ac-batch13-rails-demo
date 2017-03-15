class Event < ApplicationRecord
	has_many :attendees
	belongs_to :category, optional: true

	delegate :name, :to => :category, :prefix => true, :allow_nil => true
end
