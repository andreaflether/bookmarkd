# frozen_string_literal: true

class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]

  # Virtual attributes
  attr_accessor :terms

  # Constants
  FOLDER_FILTERS = %w[updated_at number_of_bookmarks name].freeze

  # Relationships
  has_many :folders, dependent: :destroy

  # Preferences
  typed_store :preferences do |s|
    s.string :order_folders_by, default: 'updated_at', null: false
  end

  # Validations
  validates :name, presence: true, length: { maximum: 50, allow_blank: true }
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false, allow_blank: true },
                       format: { with: /\A^[A-Za-z0-9_]+\Z/, allow_blank: true },
                       length: { minimum: 4, maximum: 15, allow_blank: true }

  validate :username_has_at_least_one_letter, unless: -> { username.blank? }

  validates_acceptance_of :terms,
                          message: I18n.t('activerecord.errors.models.user.attributes.terms.accepted')

  # Validations: Preferences
  validates :order_folders_by, inclusion: {
    in: FOLDER_FILTERS,
    message: I18n.t('activerecord.errors.models.user.attributes.order_folders_by.inclusion')
  }

  def username_has_at_least_one_letter
    unless username.count('a-zA-Z').positive?
      errors.add(:username, I18n.t('activerecord.errors.models.user.attributes.username.numeric_only'))
    end
  end

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    user.username = auth.info.nickname
    user.image = profile_picture(auth.info.image)

    user.save
    user
  end

  def self.profile_picture(pfp_url)
    pfp_url.sub! 'normal', '200x200' unless pfp_url.match(/default/)
    pfp_url
  end

  def pinned_folders
    folders.where(pinned: true)
  end
end
