class Tweet < ApplicationRecord
  has_many :bookmarks
  has_many :folders, through: :bookmarks, dependent: :destroy

  validates :link, 
  presence: { message: 'Tweet URL is required!' }
  
  validate :return_html_content

  def return_html_content 
    html_hash = { html_content: EmbedTweetService.new(self.link).fetch }
    content = html_hash[:html_content]
    if content.code == 403
      self.errors.add(:link, 'Only tweets from public accounts are allowed.')
    elsif content.code != 200
      self.errors.add(:link, 'Tweet URL is not valid!')
    else 
      html = JSON.parse(html_hash[:html_content].body)['html']
      self.html_content = html
    end 
  end 
end 