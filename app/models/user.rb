class User < ApplicationRecord
  has_many :folders
  validates :name, presence: true, length: { maximum: 50, allow_blank: true } 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[twitter]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.username = auth.info.nickname
      user.image = profile_picture(auth.info.image)
    end
  end

  def self.profile_picture(pfp_url)
    unless pfp_url.match(/default/)
      pfp_url.sub! 'normal', '200x200'
    end
    pfp_url
  end 
end
