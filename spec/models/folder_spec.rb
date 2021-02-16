# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  subject { build(:folder) }

  let(:folder) { create(:folder) }

  context 'when is new' do
    it { expect(folder).not_to be_pinned }
  end

  context 'associations' do
    subject { create(:folder) }

    it { expect(subject).to belong_to(:user) }
    it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
    it { is_expected.to have_many(:tweets) }
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for :bookmarks }
  end

  describe '#name' do
    it {
      expect(subject).to validate_presence_of(:name).with_message(I18n.t('activerecord.errors.models.folder.attributes.name.blank'))
    }

    it { expect(subject).to validate_length_of(:name).is_at_most(25) }
  end

  describe '#description' do
    it { expect(subject).to validate_length_of(:description).is_at_most(200) }
  end

  describe '#number_of_pinned_folders' do
    let!(:user) { create(:user) }
    let!(:folders) { create_list(:folder, 10, pinned: true, user: user) }
    let(:invalid_folder) { build(:folder, user: user, pinned: true) }

    it 'does not allow more than 10 pinned folders' do
      expect(invalid_folder).not_to be_valid
      expect(invalid_folder.errors.messages[:folders]).to eq [I18n.t(
        'activerecord.errors.models.folder.attributes.pinned.limit_reached', max_pins: folder.class.const_get('MAX_PINNED_FOLDERS')
      )]
    end
  end

  describe '#folder_already_exists' do
    subject { build(:folder, user: user) }

    let!(:user) { create(:user) }
    let!(:folder) { create(:folder, name: 'Test', user: user) }

    it {
      expect(subject).not_to allow_values('TEST', 'Test', 'tEsT', 'test')
        .for(:name)
        .with_message(I18n.t('activerecord.errors.models.folder.attributes.name.already_exists',
                             url: folder_path(folder)))
    }
  end
end
