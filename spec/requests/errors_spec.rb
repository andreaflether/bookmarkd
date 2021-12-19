# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /404' do
    before { get '/404' }
    it { expect(response).to have_http_status(:not_found) }
  end

  describe 'GET /500' do
    before { get '/500' }
    it { expect(response).to have_http_status(:internal_server_error) }
  end

  describe 'GET /422' do
    before { get '/422' }
    it { expect(response).to have_http_status(:unprocessable_entity) }
  end
end
