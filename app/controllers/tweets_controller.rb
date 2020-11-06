class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_bookmarks, only: [:destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.find_or_create_by(tweet_params)
    
    respond_to do |format|
      if @tweet.save
        Folder.find(params[:tweet][:folder_ids]).tweets << @tweet
        format.html { redirect_to request.referer, notice: 'Tweet added to folder!' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @folder = Folder.find(params[:folder_id]) if params[:folder_id]

    @tweet.destroy if @tweet.folders.count == 1 
    
    @folder.tweets.delete @tweet
    @folder.save  

    # redirect_to request.referer, notice: "Tweet successfully removed from <b>#{@folder.name}</b>."
  
    # @tweet.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: "Tweet removed successfully." }
      format.js { 
        render :destroy, 
        layout: false, 
        locals: { tweet: @tweet, folder: @folder, bookmarks: @bookmarks }  }
    end
  end

  def set_bookmarks 
    @bookmarks = current_user.folders
        .find(params[:folder_id])
        .bookmarks
        .includes([:tweet])
        .order('created_at DESC')   
        .page(params[:page])
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:link, folder_ids: [])
    end
end
