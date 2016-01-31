json.array!(@tablets) do |tablet|
  json.extract! tablet, :id, :name, :token
  json.url tablet_url(tablet, format: :json)
end
