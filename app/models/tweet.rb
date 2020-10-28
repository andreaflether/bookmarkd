class Tweet < ApplicationRecord
  has_and_belongs_to_many :folders

  validate :return_html_content
  validates :link, 
    presence: { message: 'Tweet URL is required!' },
    format: { 
      with: /http(?:s)?:\/\/(?:www\.)?twitter\.com\/([a-zA-Z0-9_]+)\/status\/\d{19}/i, 
      message: 'Incorrect format for Twitter URL!',
      allow_blank: true
    }
  
  def return_html_content 
    html_hash = { html_content: EmbedTweetService.new(self.link).fetch }

    if html_hash[:html_content].code == 404
      self.errors.add(:link, 'Tweet URL is not valid!')
    else 
      html = JSON.parse(html_hash[:html_content].body)['html']
      self.html_content = html
    end 
  end 
end 