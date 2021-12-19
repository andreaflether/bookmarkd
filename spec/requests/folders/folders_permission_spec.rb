# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :request do
  let!(:folder_owner) { create(:user) }
  let!(:another_user) { create(:user) }

  let(:public_folder) { create(:folder, privacy: 0, user: folder_owner) }
  let(:private_folder) { create(:folder, privacy: 1, user: folder_owner) }

  let(:owner_session) { { session: login_as(folder_owner) } }
  let(:another_user_session) { { session: login_as(another_user) } }

  describe 'GET /folders/:id' do
    shared_examples ':show' do |session|
      it 'includes the folder name in the page' do
        get folder_path(public_folder), params: eval(session)
        expect(response.body).to include(public_folder.name)
      end
    end

    shared_examples ':forbidden' do |session|
      it 'redirects to the forbidden page' do
        get folder_path(private_folder), params: eval(session)

        expect(response).to redirect_to(forbidden_path)
      end
    end

    describe 'privacy: PUBLIC' do
      context 'when user is logged in and owns the folder' do
        include_examples ':show', 'owner_session'
      end

      context 'when user is not logged in' do
        include_examples ':show', ''
      end

      context 'when another user is logged in' do
        include_examples ':show', 'another_user_session'
      end
    end

    describe 'privacy: PRIVATE' do
      context 'when user is logged in and owns the folder' do
        include_examples ':show', 'owner_session'
      end

      context 'when user is not logged in' do
        include_examples ':forbidden', ''
      end

      context 'when another user is logged in' do
        include_examples ':forbidden', 'another_user_session'
      end
    end
  end
end
