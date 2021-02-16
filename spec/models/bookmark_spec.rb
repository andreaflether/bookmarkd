# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  subject { build(:bookmark) }

  let!(:bookmark) { create(:bookmark) }

  context 'associations' do
    it 'is expected to belong to tweet required: true' do
      described_class.skip_callback(:validation, :before, :find_or_create_tweet)
      expect(subject).to belong_to(:tweet)
    end

    it { expect(subject).to belong_to(:folder).counter_cache(true).touch(true) }
  end

  context 'nested attributes' do
    it { expect(subject).to accept_nested_attributes_for :tweet }
  end

  describe '#tweet_id' do
    it {
      expect(subject).to validate_uniqueness_of(:tweet_id).scoped_to(:folder_id).with_message(I18n.t('activerecord.errors.models.folder.attributes.bookmark.already_listed'))
    }
  end

  it 'destroys the tweet when no other folder contains it' do
    expect { bookmark.destroy }.to change(Tweet, :count).from(1).to(0)
  end
end
