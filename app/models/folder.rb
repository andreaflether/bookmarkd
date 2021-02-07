class Folder < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :tweets, -> { distinct }, through: :bookmarks
  accepts_nested_attributes_for :bookmarks

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders]

  validates :name,
            presence: { message: I18n.t('activerecord.errors.models.folder.attributes.name.blank') },
            length: { maximum: 25 }
  validates_length_of :description, maximum: 200
  validate :number_of_pinned_folders,
           if: proc { |p| p.pinned_changed?(from: false, to: true) }

  MAX_PINNED_FOLDERS = 10

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates
    [
      [user.username, :name]
    ]
  end

  def number_of_pinned_folders
    if user.pinned_folders.count == MAX_PINNED_FOLDERS
      errors.add(:folders, I18n.t('activerecord'\
        '.errors'\
        '.models'\
        '.folder'\
        '.attributes'\
        '.pinned'\
        '.limit_reached', max_pins: MAX_PINNED_FOLDERS))
    end
  end
end
