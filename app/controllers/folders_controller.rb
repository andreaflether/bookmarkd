# frozen_string_literal: true

class FoldersController < ApplicationController
  before_action :force_json, only: %i[search]
  before_action :set_folder, only: %i[show edit update destroy toggle_pin destroy_bookmarks]
  before_action :set_bookmarks, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[show forbidden]
  load_and_authorize_resource except: %i[forbidden]

  # GET /folders/search
  def search
    @q = current_user.folders
                     .ransack(params[:q])
    @folders = @q.result
                 .order(name: :asc)
                 .limit(5)
  end

  # GET /folders
  def index
    @folders = current_user.folders
                           .order(pinned: :desc, updated_at: :desc)
  end

  # GET /folders/1
  def show; end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit; end

  # POST /folders
  def create
    @folder = Folder.new(folder_params)
    @folder.user = current_user

    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: I18n.t('controllers.folders.created') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /folders/1
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: I18n.t('controllers.folders.updated') }
        format.js do
          render 'folders/js/append_tweet',
                 locals: { bookmark: @folder.bookmarks.last, bookmarks: @folder.bookmarks_count }
        end
      else
        format.html { render :edit }
        format.js { render 'folders/js/error', layout: false, locals: { error: @folder.errors.full_messages } }
      end
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url, notice: I18n.t('controllers.folders.deleted') }
      format.js { render 'folders/js/destroy', locals: { folder: @folder } }
    end
  end

  # PUT /folders/1/toggle_pin
  def toggle_pin
    @folder.toggle(:pinned)

    respond_to do |format|
      if @folder.save
        format.js { render 'folders/js/toggle_pin_action', locals: { folder: @folder } }
      else
        format.js { render 'folders/js/error', layout: false, locals: { error: @folder.errors.full_messages } }
      end
    end
  end

  # DELETE /folders/1/destroy_bookmarks
  def destroy_bookmarks
    @folder.bookmarks.destroy_all

    redirect_to edit_folder_path(@folder), notice: I18n.t('controllers.folders.deleted_bookmarks', folder: @folder.name)
  end

  def forbidden; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_folder
    @folder = Folder.find_by!(slug: params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to not_found_path
  end

  def set_bookmarks
    @bookmarks = @folder.bookmarks
                        .includes([:tweet])
                        .before(id: params[:cursor]).limit(10)
  end

  def force_json
    request.format = :json
  end

  # Only allow a list of trusted parameters through.
  def folder_params
    params.require(:folder).permit(:name, :description, :pinned, :privacy,
                                   bookmarks_attributes: [tweet_attributes: %i[id link]])
  end
end
