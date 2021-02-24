# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user_params) { attributes_for(:user) }
  let(:user) { create(:user) }

  context 'After successfully completing the sign-up form' do
    before { post user_registration_path, params: { user: user_params } }

    it { expect(response).to redirect_to(root_path) }
  end

  context 'After successful login' do
    before { post user_session_path, params: { user: { email: user.email, password: '12345678' } } }

    it { expect(response).to redirect_to(root_path) }
  end
end
