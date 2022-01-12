# frozen_string_literal: true

class Tweet < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :folders, through: :bookmarks, dependent: :destroy

  validates :link,
            presence: { message: I18n.t('activerecord.errors.models.tweet.attributes.link.blank') }

  validate :return_html_content

  def return_html_content
    html_hash = { html_content: EmbedTweetService.new(link).fetch }
    content = html_hash[:html_content]
    if content.code == 403
      errors.add(:link, I18n.t('activerecord.errors.models.tweet.attributes.link.private'))
    elsif content.code != 200
      errors.add(:link, I18n.t('activerecord.errors.models.tweet.attributes.link.invalid'))
    else
      html = JSON.parse(html_hash[:html_content].body)['html']
      self.html_content = html
    end
  end

  def media
    html_content.scan(/pic.twitter.com\/.{10}/)&.first
  end
end
