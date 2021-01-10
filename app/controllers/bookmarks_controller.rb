class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]

  def destroy
    @bookmark.destroy
    @folder = Folder.find(params[:folder_id])

    respond_to do |format|
      format.js { 
        render :destroy, 
        layout: false, 
        locals: { tweet: @bookmark.tweet, folder: @folder, bookmarks: @folder.bookmarks_count }  }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
