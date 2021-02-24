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

  describe '#title' do
    context 'when translation is missing' do
      before { helper.content_for(:title, 'translation_missing') }

      it { expect(helper.title).to eq('Bookmarkd') }
    end

    context 'when content_for is present' do
      before { helper.content_for(:title, 'Test') }

      it { expect(helper.title).to eq('Test / Bookmarkd') }
    end

    context 'when translation exists in i18n' do
      before do
        allow(helper).to receive(:controller_path).and_return 'folders'
        allow(helper).to receive(:action_name).and_return 'new'
      end

      it { expect(helper.title).to eq('New folder / Bookmarkd') }
    end
  end

  describe '#application_mode and #light_mode?' do
    context 'when cookies[:sun] are present' do
      before { helper.request.cookies[:sun] = 'light mode on' }

      it { expect(helper.application_mode).to eq('light') }
      it { expect(helper.light_mode?).to eq('light mode on') }
    end

    context 'when no cookies are present' do
      it { expect(helper.application_mode).to eq('dark') }
      it { expect(helper).not_to be_light_mode }
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
