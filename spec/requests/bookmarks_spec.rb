# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :request do
  let!(:user) { create(:user) }
  let!(:folder) { create(:folder, user: user) }
  let(:bookmark) { create(:bookmark, folder: folder) }

  describe 'DELETE /folders/:folder_id/bookmarks/:id' do 
    before do
      delete folder_bookmark_path(folder, bookmark), params: { format: :js } 
    end

    it { expect(response).to have_http_status(:ok) }
    it {
      expect(response.body).to include(I18n.t('controllers.folders.tweet.deleted',
                                              folder: folder[:name]))
    }

    it { expect(response).to render_template(:destroy) }
  end
end