json.array!(@messages) do |message|
  json.extract! message, :id, :uuid, :payload, :gcm_response, :gcm_response_code, :accept_status, :tablet_id
  json.url message_url(message, format: :json)
end
