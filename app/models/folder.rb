class Folder < ApplicationRecord
  attr_accessor :tweets_count

  belongs_to :user 
  has_and_belongs_to_many :tweets
  accepts_nested_attributes_for :tweets

  extend FriendlyId
  friendly_id  :slug_candidates,  use: [:slugged, :finders]

  validate :no_duplicate_tweets
  
  before_validation :verify_existing_tweets, unless: Proc.new { |f| f.tweets.any? }
  before_save :search_tweet

  validates :name, 
    presence: { message: 'Folder name is required.' }, 
    length: { maximum: 25 }
  validates_length_of :description, maximum: 200
  

  def tweets_count
    self.tweets.count
  end 
  
  def no_duplicate_tweets
    if self.tweets.any? && self.tweets.group_by { |t| get_tweet_id(t.link) }.values.detect{ |arr| arr.size > 1 }
      self.errors.add(:tweets, 'Tweet already exists in this folder!')  
    end
  
  end

  def search_tweet
    self.tweets = self.tweets.map do |tweet|
      Tweet.where("link LIKE ?", "%#{get_tweet_id(tweet.link)}%").first_or_initialize do |t|
        t.link = tweet.link
      end 
    end
  end

  def verify_existing_tweets
    begin
      self.tweets = self.tweets.map do |tweet|
        Tweet.where("link LIKE ?", "%#{get_tweet_id(tweet.link)}%").first_or_initialize 
      end
    rescue ActiveRecord::RecordNotUnique
      self.errors.add(:tweets, 'Tweet already exists in this folder!')
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
      [ :id, Faker::Number.unique.number(digits: 4), :name ]
    ]
  end 
end
