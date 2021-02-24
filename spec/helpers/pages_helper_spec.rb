# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  describe '#not_edit_user_registration_path' do
    context 'registrations#edit' do
      before do
        allow(helper).to receive(:controller_name).and_return('registrations')
        allow(helper).to receive(:action_name).and_return('edit')
      end

      it { expect(helper.not_edit_user_registration_path).to eq(true) }
    end

    context 'test_controller#test' do
      before do
        allow(helper).to receive(:controller_name).and_return('test_controller')
        allow(helper).to receive(:action_name).and_return('test')
      end

      it { expect(helper.not_edit_user_registration_path).to eq(false) }
    end
  end
end
