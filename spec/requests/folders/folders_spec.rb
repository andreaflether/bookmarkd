# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :request do
  let!(:user) { create(:user) }
  let(:folder) { create(:folder, user: user) }

  # shared_context('unauthenticated_user') do |method, path|
  #   context 'when user is NOT logged in' do
  #     before { eval("#{method} #{path}") }

  #     it { expect(response).to redirect_to(new_user_session_path) }

  #     it "is expected to display message: '#{I18n.t('devise.failure.unauthenticated')}'" do
  #       follow_redirect!
  #       expect(response.body).to include(I18n.t('devise.failure.unauthenticated'))
  #     end
  #   end
  # end

  describe 'GET /folders' do
    # include_context 'unauthenticated_user', 'get', 'folders_path'
    before { get folders_path, params: { session: login_as(user) } }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET /folders/:id' do
    let(:another_folder) { create(:folder) }

    context 'when user is logged in' do
      before { get folder_path(folder), params: { session: login_as(user) } }

      it { expect(response).to render_template(:show) }
      it { expect(response).to have_http_status(:ok) }
    end

    context "when user is logged in, but the folder doesn't belong to the user who created it" do
      before { get folder_path(another_folder), params: { session: login_as(user) } }

      it "is expected to display message: '#{I18n.t('controllers.folders.forbidden_access')}'" do
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.folders.forbidden_access'))
      end

      it 'is expected to render template :index' do
        follow_redirect!
        expect(response).to render_template(:index)
      end

      it { expect(response).to redirect_to(folders_path) }
    end
  end

  describe 'GET /folders/new' do
    before { get new_folder_path, params: { session: login_as(user) } }

    it { expect(response).to render_template(:new) }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST /folders' do
    before { post folders_path, params: { folder: folder_params, user: user, session: login_as(user) } }

    context 'when the params are valid' do
      let(:folder_params) { attributes_for(:folder) }

      it { expect(user.folders.find_by(name: folder_params[:name])).not_to be_nil }

      it "is expected to display message: '#{I18n.t('controllers.folders.created')}'" do
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.folders.created'))
      end

      it 'is expected to render template :show' do
        follow_redirect!
        expect(response).to render_template(:show)
      end

      it { expect(response).to redirect_to(folder_path(user.folders.last)) }
    end

    context 'when the params are invalid' do
      let(:folder_params) { attributes_for(:folder, name: '') }

      it { expect(user.folders.find_by(name: folder_params[:name])).to be_nil }
      it { expect(response.body).to include(I18n.t('activerecord.errors.models.folder.attributes.name.blank')) }
    end
  end

  describe 'GET /folders/:id/edit' do
    before { get edit_folder_path(folder), params: { session: login_as(user) } }

    it { expect(response).to render_template(:edit) }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'PUT/PATCH /tasks' do
    before { put folder_path(folder), params: { folder: folder_params, user: user, session: login_as(user) } }

    context 'when the params are valid' do
      let(:folder_params) { attributes_for(:folder, name: 'New folder name') }

      it { expect(user.folders.find_by(name: folder_params[:name])).not_to be_nil }

      it "is expected to display message: '#{I18n.t('controllers.folders.updated')}'" do
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.folders.updated'))
      end

      it 'is expected to render template :show' do
        follow_redirect!
        expect(response).to render_template(:show)
      end

      it { expect(response).to redirect_to(folder_path(user.folders.last)) }
    end

    context 'when the params are invalid' do
      let(:folder_params) { attributes_for(:folder, name: '') }

      it { expect(response.body).to include(I18n.t('activerecord.errors.models.folder.attributes.name.blank')) }
    end
  end

  describe 'DELETE /folders/:id' do
    let(:deleted_folder) { create(:folder, user: user) }

    before { delete folder_path(deleted_folder), params: { session: login_as(user) } }

    it "is expected to display message: '#{I18n.t('controllers.folders.deleted')}'" do
      follow_redirect!
      expect(response.body).to include(I18n.t('controllers.folders.deleted'))
    end

    it 'is expected to render template :index' do
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it { expect(response).to redirect_to(folders_path) }
  end
end
