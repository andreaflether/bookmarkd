class Tweet < ApplicationRecord
  has_many :bookmarks
  has_many :folders, through: :bookmarks, dependent: :destroy

  validates :link, 
  presence: { message: 'Tweet URL is required!' },
  format: { 
    with: /http(?:s)?:\/\/(?:www\.)?twitter\.com\/([a-zA-Z0-9_]+)\/status\/\d{18,19}/i, 
    message: 'Incorrect format for Twitter URL!',
    allow_blank: true
  }
  # ,
  # uniqueness: { message: 'Tweet already exists in the database. ' }
  validate :return_html_content

  def return_html_content 
    html_hash = { html_content: EmbedTweetService.new(self.link).fetch }
    content = html_hash[:html_content]
    if content.code != 200
      self.errors.add(:link, 'Tweet URL is not valid!')
    else 
      html = JSON.parse(html_hash[:html_content].body)['html']
      self.html_content = html
    end 
  end 
end 