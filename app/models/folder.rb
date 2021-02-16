# frozen_string_literal: true

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

  validates :description, length: { maximum: 200 }
  validate :number_of_pinned_folders,
           if: proc { |p| p.pinned_changed?(from: false, to: true) }

  validate :folder_already_exists, unless: proc { |p| p.name.blank? || !p.name_changed? }

  MAX_PINNED_FOLDERS = 10

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def slug_candidates
    [
      # [ user.username, :name ],
      [user.username, Digest::MD5.hexdigest(name + created_at.to_s)]
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

  def folder_already_exists
    return unless search_folder_by_name.any?

    errors.add(:name, I18n.t('activerecord'\
                             '.errors'\
                             '.models'\
                             '.folder'\
                             '.attributes'\
                             '.name'\
                             '.already_exists',
                             url: path_to(search_folder_by_name.first)).html_safe)
  end

  def path_to(folder)
    Rails.application.routes.url_helpers.folder_path(folder)
  end

  def search_folder_by_name
    user.folders.where('lower(name) = ?', name.downcase)
  end
end
