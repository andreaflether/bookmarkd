# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#toastr_class_for' do
    it { expect(helper.toastr_class_for('success')).to eq('success') }
    it { expect(helper.toastr_class_for('error')).to eq('error') }
    it { expect(helper.toastr_class_for('alert')).to eq('warning') }
    it { expect(helper.toastr_class_for('notice')).to eq('info') }
  end

  describe '#custom_flash_messages' do
    context 'when flash message is present' do
      before { controller.flash[:success] = 'Success!' }

      it { expect(helper.custom_flash_messages).to eq('<script>toastr["success"]("Success!");</script>') }
      it { expect(flash.to_h).not_to have_key(:success) }
    end

    context 'when flash message is not present' do
      it { expect(helper.custom_flash_messages).to be_blank }
    end
  end

  describe '#application_mode and #light_mode?' do
    context 'when theme is dark' do
      before { helper.request.cookies[:_bookmarkd_theme] = 'dark' }

      it { expect(helper.application_mode).to eq('dark') }
      it { expect(helper).not_to be_light_mode }
    end

    context 'when theme is light' do
      it { expect(helper.application_mode).to eq('light') }
      it { expect(helper).to be_light_mode }
    end
  end

  describe '#sort_by_template' do
    let(:sort_by_options) { %w[updated_at number_of_bookmarks name] }

    it do
      sort_by = sort_by_options.sample
      expect(helper.sort_by_template('Teste',
                                     sort_by)).to include("data-sort-by=\"#{sort_by}\"", 'Teste',
                                                          "href=\"/order_folders_by?order_folders_by=#{sort_by}\"")
    end
  end
end
