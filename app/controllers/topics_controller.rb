class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
    @new_bookmark = Bookmark.new
  end

  def new
    #@topic = Topic.new
    @topic = current_user.topics.build
  end

  def edit
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:title))
    @topic.user = current_user
    if @topic.save
      flash[:notice] = "\"#{@topic.title}\" was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end
end