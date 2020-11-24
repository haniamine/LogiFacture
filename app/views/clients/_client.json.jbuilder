json.extract! client, :id, :nom, :email, :encours, :created_at, :updated_at
json.url client_url(client, format: :json)
