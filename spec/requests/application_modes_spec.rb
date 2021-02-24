# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application modes (Sun/Moon)', type: :request do
  let(:headers) do
    { 'HTTP_REFERER': 'http://localhost:3000' }
  end

  context 'dark mode ==> light mode' do
    before { get sun_path, headers: headers }

    it { expect(cookies[:sun]).to eq 'light mode on' }
    it { expect(response).to redirect_to(request.referer) }
  end

  context 'light mode ==> dark mode' do
    before do
      cookies[:sun] = 'light mode on'
      get moon_path, headers: headers
    end

    it { expect(cookies[:sun]).to eq('') }
    it { expect(response).to redirect_to(request.referer) }
  end
end
