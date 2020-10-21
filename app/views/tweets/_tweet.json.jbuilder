json.extract! tweet, :id, :link, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
