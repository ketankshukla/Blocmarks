class BookmarksController < ApplicationController

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new(params.require(:bookmark).permit(:url))
    @bookmark.topic = @topic
    @bookmark.user = current_user
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "\"#{@bookmark.url}\" was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
      flash[:notice] = "Bookmark was updated"
      redirect_to @topic
    else
      flash[:error] = "The bookmark could not be updated. Please try again."
      render :edit
    end

  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted"
    else
      flash[:error] = "The bookmark could not be deleted. Please try again."
    end

    redirect_to @topic
  end
end