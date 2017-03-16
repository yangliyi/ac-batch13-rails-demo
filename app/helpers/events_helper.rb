module EventsHelper
	def toggle_public_button(event)
		event.is_public ? 'Unpublic' : 'Public'
	end
end
