class Admin::EventsController < ApplicationController
	before_action :authenticate

	def index
		@events = Event.all
	end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "admin" && password == "12345678"
    end
  end
end
