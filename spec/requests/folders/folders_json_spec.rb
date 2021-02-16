# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Folder - JSON', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /folders/search, format: :json' do
    before { login_as(user) }

    context 'when a search param matches a existing folder' do
      let!(:blackpink) { create(:folder, name: 'Blackpink', user: user) }
      let!(:itzy) { create(:folder, name: 'ITZAAAAAAAY', user: user) }
      let!(:twicepink) { create(:folder, name: 'Twicepink', user: user) }

      before { get search_folders_path, params: { q: { name_cont: 'pink' } } }

      it 'returns only the matching folders, in alphabetic order' do
        return_folder_names = json_body[:folders].map { |t| t[:name] }

        expect(return_folder_names).to eq([blackpink.name, twicepink.name])
      end

      it { expect(response.content_type).to eq('application/json') }
    end

    context 'when no folders are found matching the search param' do
      before { get search_folders_path, params: { q: { name_cont: '123456789' } } }

      it { expect(json_body[:folders]).to match_array([]) }
    end
  end
end
