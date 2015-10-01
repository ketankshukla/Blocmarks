class BookmarksController < ApplicationController


  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    @bookmark.update_attributes(params.require(:bookmark).permit(:url))

    redirect_to @topic
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new(params.require(:bookmark).permit(:url))
    @bookmark.topic = @topic

    if @bookmark.save
      flash[:notice] = "\"#{@bookmark.url}\" was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted"
    else
      flash[:error] = "The bookmark could not be deleted. Please try again."
    end

    redirect_to @topic
  end
end