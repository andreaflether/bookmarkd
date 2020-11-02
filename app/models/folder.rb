class Folder < ApplicationRecord
  belongs_to :user 
  has_and_belongs_to_many :tweets

  extend FriendlyId
  friendly_id  :slug_candidates,  use: [:slugged, :finders]

  accepts_nested_attributes_for :tweets
  before_update :find_tweet

  validates :name, 
    presence: { message: 'Folder name is required.' }, 
    length: { maximum: 25 }
  validates_length_of :description, maximum: 200
  
  validate :no_duplicate_tweets
  
  def no_duplicate_tweets
    if self.tweets.group_by { |t| get_tweet_id(t.link)}.values.detect{|arr| arr.size > 1}
      self.errors.add(:tweets, 'Tweet already exists in this folder!') 
    end 
  end

  def find_tweet 
    self.tweets = self.tweets.map do |tweet|
      Tweet.where("link LIKE ?", "%#{get_tweet_id(tweet.link)}%").first_or_initialize 
    end
  end

  def get_tweet_id(url)
    url.partition('/status').last.gsub("?s=20", "")
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates 
    [
      [ Faker::Number.unique.number(digits: 4), :name ], 
      [:id, Faker::Number.unique.number(digits: 4), :name]
    ]
  end 
end
