class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def order_folders_by
    current_user.order_folders_by = params[:order_folders_by]

    unless current_user.save
      respond_to do |format|
        format.js do
          render 'folders/error',
                 layout: false,
                 locals: { error: current_user.errors.full_messages }
        end
      end
    end
  end
end
