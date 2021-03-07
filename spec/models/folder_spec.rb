# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  subject { create(:folder) }

  let!(:user) { create(:user) }
  let(:folder) { create(:folder) }

  context 'when is new' do
    it { expect(folder).not_to be_pinned }
    it { expect(folder.privacy).to eq('secret') }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
    it { is_expected.to have_many(:tweets) }
  end

  context 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for :bookmarks }
  end

  describe '#privacy' do
    it {
      expect(subject).to define_enum_for(:privacy)
        .with_values(subject.class.const_get('FOLDER_PRIVACIES'))
    }

    it {
      expect(subject).to validate_presence_of(:privacy)
        .with_message(I18n.t('activerecord.errors.models.folder.attributes.privacy.blank'))
    }
  end

  describe '#name' do
    it {
      expect(subject).to validate_presence_of(:name).with_message(I18n.t('activerecord.errors.models.folder.attributes.name.blank'))
    }

    it { expect(subject).to validate_length_of(:name).is_at_most(25) }

    context 'uniqueness' do
      let!(:existing_folder) { create(:folder, name: 'Test', user: user) }
      let(:repeated_folder) { build(:folder, name: 'Test', user: user) }

      it do
        expect(repeated_folder).not_to be_valid
        expect(repeated_folder.errors.messages[:name]).to include I18n.t(
          'activerecord.errors.models.folder.attributes.name.already_exists', url: folder_path(existing_folder)
        )
      end
    end
  end

  describe '#description' do
    it { expect(subject).to validate_length_of(:description).is_at_most(200) }
  end

  describe '#number_of_pinned_folders' do
    let!(:folders) { create_list(:folder, 15, pinned: true, user: user) }
    let(:invalid_folder) { build(:folder, user: user, pinned: true) }

    it do
      expect(invalid_folder).not_to be_valid
      expect(invalid_folder.errors.messages[:folders]).to include I18n.t(
        'activerecord.errors.models.folder.attributes.pinned.limit_reached', max_pins: folder.class.const_get('MAX_PINNED_FOLDERS')
      )
    end
  end
end
