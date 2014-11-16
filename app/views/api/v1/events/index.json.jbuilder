json.array!(@api_v1_events) do |api_v1_event|
  json.extract! api_v1_event, :id, :title, :desc, :location, :url, :image_url, :start_time, :end_time
  json.url api_v1_event_url(api_v1_event, format: :json)
end
