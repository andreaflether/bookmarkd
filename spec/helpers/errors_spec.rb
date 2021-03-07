# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorsHelper, type: :helper do
  describe '#code' do
    before { helper.response.status = 404 }

    it { expect(helper.code).to be_a(String) }
  end
end
