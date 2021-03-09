# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoldersHelper, type: :helper do
  describe '#truncated_description' do
    let(:full_text) do
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    end
    let(:truncated_text) { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiu...' }

    it { expect(helper.truncated_description(full_text)).to eq(truncated_text) }
  end

  describe '#datetime_formatted' do
    let(:datetime_now) { DateTime.now }

    it { expect(helper.datetime_formatted(datetime_now)).to eq(datetime_now.strftime('%B %d, %Y %H:%M')) }
  end

  describe '#pluralize_bookmarks_count' do
    let!(:folder) { create(:folder) }
    let!(:tweet) { create(:tweet) }
    let!(:bookmark) { create(:bookmark, folder: folder, tweet: tweet) }

    it { expect(helper.pluralize_bookmarks_count(folder)).to eq('1 bookmark') }
  end

  describe '#state_name' do
    let(:unpinned_folder) { build(:folder) }
    let(:pinned_folder) { build(:folder, pinned: true) }

    it { expect(helper.state_name(unpinned_folder)).to eq('Pin') }
    it { expect(helper.state_name(pinned_folder)).to eq('Unpin') }
  end

  describe '#privacy_options' do
    it { expect(helper.privacy_options).to contain_exactly(%w[open Public], %w[secret Private]) }
  end

  describe '#keyword_confirmation' do
    let(:current_user) { create(:user) }
    let(:expected_keyword) { "#{current_user.username}/#{current_user.created_at.strftime('%m%d%y')}" }

    before { allow(helper).to receive(:current_user).and_return current_user }

    it { expect(helper.keyword_confirmation(current_user)).to eq(expected_keyword) }
  end
end
