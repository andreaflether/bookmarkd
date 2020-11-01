class Folder < ApplicationRecord
  belongs_to :user 
  has_and_belongs_to_many :tweets

  accepts_nested_attributes_for :tweets
  before_validation :find_tweet

  validates :name, 
    presence: { message: 'Folder name is required!' }, 
    length: { maximum: 25 }
  validates_length_of :description, maximum: 200
  
  validate :no_duplicate_tweets
  
  def no_duplicate_tweets
    self.errors.add(:tweets, 'Tweet already exists in this folder!') if self.tweets.group_by(&:link).values.detect{|arr| arr.size > 1}
  end

  def find_tweet 
    self.tweets = self.tweets.map do |tweet|
      Tweet.find_or_initialize_by(link: tweet.link)
    end
  end
end
