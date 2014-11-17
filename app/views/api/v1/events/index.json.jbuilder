json.array!(@events) do |event|
  json.extract! event, :id, :title, :desc, :location, :url, :image_url, :start_time, :end_time
  json.url api_v1_event_url(event, format: :json)
end
