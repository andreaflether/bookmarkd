class Folder < ApplicationRecord
  belongs_to :user 
  has_and_belongs_to_many :tweets

  accepts_nested_attributes_for :tweets

  validates_presence_of :name
  validates_length_of :description, maximum: 200
end
