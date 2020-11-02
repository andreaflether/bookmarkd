class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :toggle_folder_pin]
  before_action :authenticate_user!
  before_action :verify_user, only: [:show, :edit, :update, :destroy]

  # GET /folders
  def index
    @folders = Folder.where(user: current_user)
      .order(pinned: :desc, updated_at: :desc)
  end

  # GET /folders/1
  def show
    @tweets = current_user.folders
      .find(@folder.id)
      .tweets
      .paginate(page: params[:page], per_page: 10)
      .order('created_at DESC')   
    
    respond_to do |format|
      format.html
      format.js
    end
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
        format.js { render :append_tweet, locals: { tweet: @folder.tweets.last } }
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
      format.json { head :no_content }
    end
  end

  def toggle_folder_pin
    @folder.toggle(:pinned)

    respond_to do |format|
      if @folder.save 
        format.js { render :toggle_pin_action, locals: { folder: @folder } }
      else 
        format.js { 
          render :errors,
          layout: false, 
          locals: { error: @folder.errors.full_messages } 
        }
      end 
    end 
  end

  def verify_user
    unless helpers.folder_belongs_to_user(@folder) && user_signed_in?
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
      params.require(:folder).permit(:name, :description, :pinned, tweets_attributes: [ :id, :link ])
    end
end
