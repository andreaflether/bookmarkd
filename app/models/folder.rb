class Folder < ApplicationRecord
  belongs_to :user 
  has_many :bookmarks, dependent: :destroy
  has_many :tweets, -> { distinct }, through: :bookmarks

  accepts_nested_attributes_for :bookmarks 

  extend FriendlyId
  friendly_id  :slug_candidates,  use: [:slugged, :finders]

  validates :name, 
    presence: { message: 'Folder name is required.' }, 
    length: { maximum: 25 }
  validates_length_of :description, maximum: 200

  def get_tweet_id(url)
    url.partition('/status').last.gsub("?s=20", "")
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates 
    [ 
      :name,
      [ Faker::Number.unique.number(digits: 4), :name ] 
    ]
  end 
end
