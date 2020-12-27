class Bookmark < ApplicationRecord
  belongs_to :folder, counter_cache: true
  belongs_to :tweet

  accepts_nested_attributes_for :tweet

  before_validation :find_or_create_tweet, unless: Proc.new { |p| p.tweet.invalid? } 

  validates_uniqueness_of :tweet_id,
                          scope: :folder_id,
                          message: 'Tweet is already listed in this folder!'

  def find_or_create_tweet
    # Find or create the author by tweet status ID
    query = Tweet.where("link LIKE ?", "%#{get_tweet_id(tweet.link)}%")
    query.any? ? self.tweet = query.first : self.tweet.save
  end

  def get_tweet_id(url)
    url.partition('/status').last.gsub("?s=20", "")
  end
end
