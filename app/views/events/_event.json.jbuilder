json.extract! event, :id, :name, :descrption, :is_public, :capacity, :created_at, :updated_at
json.url event_url(event, format: :json)
