class Folder < ApplicationRecord
  belongs_to :user 
  has_and_belongs_to_many :tweets

  accepts_nested_attributes_for :tweets

  validates :name, 
    presence: { message: 'Folder name is required' }, 
    length: { maximum: 25 }
  validates_length_of :description, maximum: 200
end
