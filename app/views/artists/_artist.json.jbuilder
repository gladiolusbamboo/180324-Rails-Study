json.extract! artist, :id, :listener_id, :name, :birth, :url, :ctype, :photo, :created_at, :updated_at
json.url artist_url(artist, format: :json)
