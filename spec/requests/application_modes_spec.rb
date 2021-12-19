# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application modes (Sun/Moon)', type: :request do
  let(:headers) do
    { 'HTTP_REFERER': 'http://localhost:3000' }
  end

  context 'dark mode ==> light mode' do
    before { get sun_path, headers: headers }

    it { expect(cookies[:_bookmarkd_theme]).to eq 'light' }
    it { expect(response).to redirect_to(request.referer) }
  end

  context 'light mode ==> dark mode' do
    before do
      cookies[:_bookmarkd_theme] = 'light'
      get moon_path, headers: headers
    end

    it { expect(cookies[:_bookmarkd_theme]).to eq('dark') }
    it { expect(response).to redirect_to(request.referer) }
  end
end
