require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:folder) { create(:folder, pinned: true, user: user) }

  context 'when is new' do
    it { expect(user.order_folders_by).to eq('updated_at') }
  end

  describe '#username' do
    it {
      expect(subject).to validate_length_of(:username)
        .is_at_most(15)
        .with_message(I18n.t('activerecord.errors.models.user.attributes.username.too_long', count: 15))
    }

    it {
      expect(subject).to validate_length_of(:username)
        .is_at_least(4)
        .with_message(I18n.t('activerecord.errors.models.user.attributes.username.too_short', count: 4))
    }

    it {
      expect(user).to validate_uniqueness_of(:username)
        .case_insensitive
        .with_message(I18n.t('activerecord.errors.models.user.attributes.username.taken'))
    }

    it {
      expect(subject).to allow_values(
        'user_1', 'u12345', '__user_2', 'USERNAME', 'USeR_NaM3', '_Us3rN4M3__'
      ).for(:username)
    }

    it {
      expect(subject).not_to allow_value('123456').for(:username)
                                                  .with_message(I18n.t('activerecord.errors.models.user.attributes.username.numeric_only'))
    }

    it {
      expect(subject).not_to allow_values(
        'user!', 'use#rn4m3', '#user', '!$%*()', 'user@',
        'user!name', 'user name', 'user-name', 'user12@'
      )
        .for(:username)
        .with_message(I18n.t('activerecord.errors.models.user.attributes.username.invalid'))
    }
  end

  context 'associations' do
    it { is_expected.to have_many(:folders).dependent(:destroy) }
  end

  describe '#terms' do
    it { is_expected.to respond_to(:terms) }

    it {
      expect(subject).to validate_acceptance_of(:terms)
        .with_message(I18n.t('activerecord.errors.models.user.attributes.terms.accepted'))
    }
  end

  describe '#name' do
    it {
      expect(subject).to validate_presence_of(:name)
        .with_message(I18n.t('activerecord.errors.models.user.attributes.name.blank', attribute: 'Name'))
    }

    it {
      expect(subject).to validate_length_of(:name)
        .is_at_most(50)
        .with_message(I18n.t('activerecord.errors.models.user.attributes.name.too_long', count: 50))
    }
  end

  describe '#order_folders_by (typed_store)' do
    it {
      expect(subject).to validate_inclusion_of(:order_folders_by)
        .in_array(subject.class.const_get('FOLDER_FILTERS'))
        .with_message(I18n.t('activerecord.errors.models.user.attributes.order_folders_by.inclusion'))
    }
  end

  describe '#pinned_folders' do
    it 'is expected to include a user pinned folder' do
      folder = create(:folder, pinned: true, user: user)
      expect(user.pinned_folders).to include(folder)
    end
  end
end
