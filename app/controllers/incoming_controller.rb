class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    @user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])

    @url = params["body-plain"]

    if @user.nil?
      @user = User.new(email: params[:sender], password: "password")
      @user.skip_confirmation!
      @user.save!
    end

    if @topic.nil?
      @topic = @user.topics.create(title: params[:subject])
    end

    @bookmark = @topic.bookmarks.create(url: @url)

    head 200
  end

=begin
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    Rails.logger.info "INCOMING PARAMS HERE: #{params}"

    @user = User.find_by(email: params[:sender])
    Rails.logger.info "User: #{@user.inspect}"

    if @user
      @topic = Topic.find_or_create_by(title: params[:subject])
      @bookmark = Bookmark.new(url: params["stripped-text"])
      @bookmark.user = @user
      @bookmark.topic = @topic
      Rails.logger.info ">>>> bookmark: #{@bookmark.inspect}"
      @bookmark.save
    end

    head 200
=end

end
