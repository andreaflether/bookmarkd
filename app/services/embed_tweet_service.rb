# frozen_string_literal: true

require 'rest-client'
require 'json'

class EmbedTweetService
  def initialize(tweet_url)
    @tweet_url = tweet_url
  end

  def fetch
    tweet = "url=#{@tweet_url}"
    base_url = "https://publish.twitter.com/oembed?#{tweet}"
    response = RestClient.get base_url
  rescue RestClient::ExceptionWithResponse => e
    e.response
  end
end
