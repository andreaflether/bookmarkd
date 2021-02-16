# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Folder - JS', type: :request do
  let!(:user) { create(:user) }
  let(:folder) { create(:folder, user: user) }

  describe 'PUT/PATCH /folders/:id, format: :js' do
    before do
      put folder_path(folder), params: {
        folder: folder_params_with_tweet,
        user: user,
        session: login_as(user),
        format: :js
      }
    end

    let(:folder_params_with_tweet) do
      attributes_for(:folder, bookmarks_attributes: [{ tweet_attributes: attributes_for(:tweet) }])
    end

    it { expect(response).to have_http_status(:ok) }

    it {
      expect(response.body).to include(I18n.t('controllers.folders.tweet.added',
                                              folder: folder_params_with_tweet[:name]))
    }

    it { expect(response).to render_template(:append_tweet) }
  end

  describe 'PUT /folders/pin_folder/:id, format: :js' do
    let(:unpinned_folder) { create(:folder, pinned: false, user: user) }
    let(:pinned_folder) { create(:folder, pinned: true, user: user) }

    context 'when folder is NOT pinned' do
      before { put toggle_pin_folders_path(unpinned_folder), params: { session: login_as(user), format: :js } }

      it { expect { unpinned_folder.reload.pinned }.to change(unpinned_folder, :pinned).from(false).to(true) }
      it { expect(response.body).to include(I18n.t('controllers.folders.pin', folder: unpinned_folder.name)) }
    end

    context 'when folder is pinned' do
      before { put toggle_pin_folders_path(pinned_folder), params: { session: login_as(user), format: :js } }

      it { expect { pinned_folder.reload.pinned }.to change(pinned_folder, :pinned).from(true).to(false) }
      it { expect(response.body).to include(I18n.t('controllers.folders.unpin', folder: pinned_folder.name)) }
    end

    context 'when user already has 10 pinned folders and tries do pin another one' do 
      let!(:folders) { create_list(:folder, 10, pinned: true, user: user) }
      let(:invalid_folder) { create(:folder, user: user) }

      before { put toggle_pin_folders_path(invalid_folder), params: { session: login_as(user), format: :js } }

      it { expect(response.body).to include(
        I18n.t('activerecord.errors.models.folder.attributes.pinned.limit_reached', max_pins: folder.class.const_get('MAX_PINNED_FOLDERS'))
      ) }

      it { expect(response).to render_template(:error) }
    end
  end

  describe 'DELETE /folders/:id, format: :js' do
    let(:deleted_folder) { create(:folder, user: user) }

    before { delete folder_path(deleted_folder), params: { session: login_as(user), format: :js } }

    it { expect(response.body).to include(I18n.t('controllers.folders.deleted')) }

    it { expect(response).to render_template(:destroy) }
  end
end
