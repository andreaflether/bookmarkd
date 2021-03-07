# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :tweets, -> { distinct }, through: :bookmarks
  accepts_nested_attributes_for :bookmarks

  MAX_PINNED_FOLDERS = 15
  FOLDER_PRIVACIES = %w[open secret].freeze

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders]

  enum privacy: FOLDER_PRIVACIES

  validates :name,
            presence: { message: I18n.t('activerecord.errors.models.folder.attributes.name.blank') },
            length: { maximum: 25 },
            uniqueness: {
              scope: :user_id,
              case_sensitive: false,
              message: lambda do |object, _data|
                I18n.t('activerecord.errors.models.folder.attributes.name.already_exists',
                       url: object.user.folders.find_by({ name: _data[:value] }).get_folder_path)
              end
            }

  validates :description, length: { maximum: 200 }
  validate :number_of_pinned_folders,
           if: -> { pinned_changed?(from: false, to: true) }
  validates :privacy, presence: { message: I18n.t('activerecord.errors.models.folder.attributes.privacy.blank') }

  def slug_candidates
    [
      [Digest::MD5.hexdigest(user.username + Time.now.to_i.to_s)]
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

  def get_folder_path
    Rails.application.routes.url_helpers.folder_path(self)
  end
end
