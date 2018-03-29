json.extract! review, :id, :cd_id, :listener_id, :status, :body, :created_at, :updated_at
json.url review_url(review, format: :json)
