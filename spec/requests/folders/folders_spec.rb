# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Folders', type: :request do
  let!(:user) { create(:user) }
  let(:folder) { create(:folder, user: user) }

  describe 'GET /folders' do
    before { get '/folders', params: { session: login_as(user) } }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET /folders/:id' do
    context 'when user is logged in' do
      before { get folder_path(folder), params: { session: login_as(user) } }

      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe 'GET /folders/new' do
    before { get new_folder_path, params: { session: login_as(user) } }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST /folders' do
    let(:valid_folder_params) { attributes_for(:folder) }
    let(:create_valid_folder) do
      post folders_path, params: { folder: valid_folder_params, user: user, session: login_as(user) }
    end

    let(:invalid_folder_params) { attributes_for(:folder, name: '') }
    let(:create_invalid_folder) do
      post folders_path, params: { folder: invalid_folder_params, user: user, session: login_as(user) }
    end

    describe '#create - increment count by 1' do
      it { expect { create_valid_folder }.to change(Folder, :count).by(1) }
    end

    describe '#create - when the params are valid' do
      before { create_valid_folder }

      it { expect(response).to redirect_to(folder_path(user.folders.last)) }

      it do
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.folders.created'))
      end
    end

    describe '#create - when the params are invalid' do
      it { expect { create_invalid_folder }.not_to change(Folder, :count) }
    end
  end

  describe 'GET /folders/:id/edit' do
    before { get edit_folder_path(folder), params: { session: login_as(user) } }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'PUT/PATCH /tasks' do
    before { put folder_path(folder), params: { folder: folder_params, user: user, session: login_as(user) } }

    context 'when the params are valid' do
      let(:folder_params) { attributes_for(:folder, name: 'New folder name') }

      it { expect(user.folders.find_by(name: folder_params[:name])).not_to be_nil }

      it do
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.folders.updated'))
      end

      it { expect(response).to redirect_to(folder_path(user.folders.last)) }
    end

    context 'when the params are invalid' do
      let(:folder_params) { attributes_for(:folder, name: '') }

      it { expect(response.body).to include(I18n.t('activerecord.errors.models.folder.attributes.name.blank')) }
    end
  end

  describe 'DELETE /folders/:id' do
    let!(:folder_to_destroy) { create(:folder, user: user) }
    let(:delete_folder) do
      delete folder_path(folder_to_destroy), params: { session: login_as(user) }
    end

    context 'redirects to the index page and displays success messsage' do
      before { delete_folder }

      it do
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.folders.deleted'))
      end

      it { expect(response).to redirect_to(folders_path) }
    end

    context 'destroys the requested folder' do
      it { expect { delete_folder }.to change(Folder, :count).by(-1) }
    end
  end

  describe 'DELETE /folders/:id/destroy_bookmarks' do
    let(:folder_with_bookmarks) { create(:folder, user: user) }
    let(:new_tweet) { create(:tweet) }
    let(:delete_folder_with_bookmarks) do
      delete destroy_bookmarks_folder_path(folder_with_bookmarks), params: { session: login_as(user) }
    end

    before { create(:bookmark, folder: folder_with_bookmarks, tweet: new_tweet) }

    context 'redirects to edit page and displays success message' do
      before { delete_folder_with_bookmarks }

      it do
        follow_redirect!
        expect(response.body).to include(
          I18n.t('controllers.folders.deleted_bookmarks', folder: folder_with_bookmarks.name)
        )
      end

      it { expect(response).to redirect_to(edit_folder_path(folder_with_bookmarks)) }
    end

    context 'destroys all bookmarks from requested folder' do
      it { expect { delete_folder_with_bookmarks }.to change(Bookmark, :count).by(-1) }
    end
  end
end
