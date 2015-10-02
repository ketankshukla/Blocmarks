class LikesController < ApplicationController
  before_action :set_topic
  before_action :set_bookmark

  def create
    @like = current_user.likes.build( bookmark_id: @bookmark.id )
    authorize @like

    respond_to do |format|
      if @like.save
        format.html { redirect_to [ @bookmark.topic, @bookmark ], notice: 'Successfully liked bookmark!' }
        format.js
      else
        format.html { redirect_to [ @bookmark.topic, @bookmark ], error: 'Error liking bookmark.'  }
        format.js
      end
    end
  end

  def destroy
    @like = current_user.likes.find_by( bookmark_id: @bookmark.id )
    authorize @like

    respond_to do |format|
      if @like.destroy
        format.html { redirect_to [ @bookmark.topic, @bookmark ], notice: 'Successfully unliking bookmark!' }
        format.js
      else
        format.html { redirect_to [ @bookmark.topic, @bookmark ], error: 'Error unliking bookmark.'  }
        format.js
      end
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_bookmark
    @bookmark = @topic.bookmarks.find(params[:bookmark_id])
  end
end