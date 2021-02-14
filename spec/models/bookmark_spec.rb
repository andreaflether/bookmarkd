# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { build(:bookmark) }

  context 'associations' do
    xit { expect(bookmark).to belong_to(:tweet) }
    it { expect(bookmark).to belong_to(:folder).counter_cache(true).touch(true) }
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for :tweet }
  end

  describe '#tweet_id' do
    it {
      expect(bookmark).to validate_uniqueness_of(:tweet_id).scoped_to(:folder_id).with_message(I18n.t('activerecord.errors.models.folder.attributes.bookmark.already_listed'))
    }
  end
end
