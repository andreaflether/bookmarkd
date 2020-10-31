class Folder < ApplicationRecord
  belongs_to :user 
  has_and_belongs_to_many :tweets

  accepts_nested_attributes_for :tweets

  validates :name, 
    presence: { message: 'Folder name is required!' }, 
    length: { maximum: 25 }
  validates_length_of :description, maximum: 200
  
  validate :no_duplicate_tweets
  
  def no_duplicate_tweets
    self.errors.add(:tweets, 'Tweet already exists in this folder!') if self.tweets.group_by(&:link).values.detect{|arr| arr.size > 1}
  end

  # before_validation :find_tweet

  # def find_tweet 
  #   self.tweets.map do |tweet|
  #     Tweet.where(link: tweet.link).first_or_initialize
  #   end
  #   rescue ActiveRecord::RecordNotUnique
  #     self.errors.add(:tweets, 'Tweet already exists in this folder.')  
  # end
end
