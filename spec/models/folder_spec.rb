# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:folder) { build(:folder) }

  context 'when is new' do
    it { expect(folder).not_to be_pinned }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
    it { is_expected.to have_many(:tweets) }
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for :bookmarks }
  end

  describe '#name' do
    let(:user) { create(:user) }
    let(:folder) { create(:folder, user: user) }

    it {
      expect(folder).to validate_presence_of(:name).with_message(I18n.t('activerecord.errors.models.folder.attributes.name.blank'))
    }

    it { expect(folder).to validate_length_of(:name).is_at_most(25) }
  end

  describe '#description' do
    it { is_expected.to validate_length_of(:description).is_at_most(200) }
  end

  describe '#number_of_pinned_folders' do
    let!(:user) { create(:user) }
    let!(:folders) { create_list(:folder, 10, pinned: true, user: user) }
    let(:invalid_folder) { build(:folder, user: user, pinned: true) }

    it 'does not allow more than 10 pinned folders' do
      expect(invalid_folder).not_to be_valid
      expect(invalid_folder.errors.messages[:folders]).to eq [I18n.t(
        'activerecord.errors.models.folder.attributes.pinned.limit_reached', max_pins: 10
      )]
    end
  end
end
