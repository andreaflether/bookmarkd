require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:tweet) { build(:tweet) }
  let(:private_tweet) { build(:tweet, link: 'https://twitter.com/andreaflether/status/362655172079534080') }
  let(:invalid_tweet) { build(:tweet, link: 'https://twitter.com/Twitter/status/0123456789012345678') }

  context 'associations' do
    it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
    it { is_expected.to have_many(:folders).dependent(:destroy) }
  end

  describe '#link' do
    it {
      expect(subject).to validate_presence_of(:link).with_message(I18n.t('activerecord.errors.models.tweet.attributes.link.blank'))
    }
  end

  context 'invalid links' do
    it 'is expected to not allow tweets from private accounts' do
      expect(private_tweet).not_to be_valid
      expect(private_tweet.errors.messages[:link]).to eq [I18n.t(
        'activerecord.errors.models.tweet.attributes.link.private'
      )]
    end

    it 'is expected to not allow tweets with invalid or non existent links' do
      expect(invalid_tweet).not_to be_valid
      expect(invalid_tweet.errors.messages[:link]).to eq [I18n.t(
        'activerecord.errors.models.tweet.attributes.link.invalid'
      )]
    end
  end
end
