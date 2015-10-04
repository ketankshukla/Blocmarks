class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      respond_to do |format|
        format.html { redirect_to [ @bookmark.topic ], notice: 'Successfully liked bookmark!' }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { redirect_to [ @bookmark ], error: 'Error liking bookmark.'  }
        format.js {}
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    if like.destroy
      respond_to do |format|
        format.html { redirect_to [ @bookmark.topic], notice: 'Successfully unliked  bookmark!' }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { redirect_to [ @bookmark.topic], error: 'Error unliking bookmark.'  }
        format.js {}
      end
    end
  end



end