class FoldersController < ApplicationController
  before_action :force_json, only: [:search]
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :toggle_folder_pin]
  before_action :verify_user, only: [:show, :edit, :update, :destroy]
  before_action :set_bookmarks, only: [:show, :update, :destroy]
  before_action :authenticate_user!

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
    @q = current_user.folders 
      .ransack(params[:q])
    @folders = @q.result
      .order(pinned: :desc, updated_at: :desc)
      .page(params[:page])
    @search = params[:q]['name_or_description_cont'] if params[:q]  
  end

  # GET /folders/1
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def set_bookmarks 
    @bookmarks = current_user.folders
      .find(@folder.id)
      .bookmarks
      .includes([:tweet])
      .order('created_at DESC')   
      .page(params[:page])
  end 

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
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /folders/1
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :append_tweet, status: :ok, location: @folder }
        format.js { 
          render :append_tweet, 
          locals: { bookmark: @folder.bookmarks.last, bookmarks: @bookmarks } 
        }
      else
        format.html { render :edit }
        format.js { 
          render :error, 
          layout: false, 
          locals: { error: @folder.errors.full_messages } 
        }
      end
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Folder was successfully deleted.' }
      format.js { 
        render :destroy,
        locals: { folder: @folder }
       }
    end
  end

  def toggle_folder_pin
    @folder.toggle(:pinned)

    respond_to do |format|
      if @folder.save 
        format.js { render :toggle_pin_action, locals: { folder: @folder } }
      else 
        format.js { 
          render :error,
          layout: false, 
          locals: { error: @folder.errors.full_messages } 
        }
      end 
    end 
  end

  def verify_user
    unless folder_belongs_to_user?(@folder)
      redirect_to folders_path, alert: 'This folder was not shared with you.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_folder
    @folder = Folder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def folder_params
    params.require(:folder).permit(:name, :description, :pinned, 
      bookmarks_attributes: [ tweet_attributes: [ :id, :link ] ]
    )
  end

  def force_json 
    request.format = :json
  end
end
