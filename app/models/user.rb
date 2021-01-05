class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[twitter]

  # Virtual attributes
  attr_accessor :terms

  # Relationships
  has_many :folders
  
  # Preferences
  typed_store :preferences do |s|
    s.string :order_folders_by, default: 'original-order', null: false
  end
  
  # Validations
  validates :name, presence: true, length: { maximum: 50, allow_blank: true } 

  validates_acceptance_of :terms, message: 'You need to accept the terms and conditions.'

  # Validations: Preferences
  validates :order_folders_by, inclusion: { 
    in: %w(original-order number_of_tweets name),
    message: 'Please provide a valid filter.'
  }  

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
    unless pfp_url.match(/default/)
      pfp_url.sub! 'normal', '200x200'
    end
    pfp_url
  end 
  
  def pinned_folders
    folders.where(pinned: true)
  end
end
