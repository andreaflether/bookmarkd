json.bookmarks do
  json.array!(@bookmarks) do |bookmark|
    json.added_in bookmark.created_at
    json.embedded_tweet bookmark.tweet.html_content
    json.tweet_url bookmark.tweet.link
  end
end
