json.extract! listener, :id, :listenername, :password_digest, :email, :is_male, :roles, :reviews_count, :created_at, :updated_at
json.url listener_url(listener, format: :json)
