class UsersController < ApplicationController
  def likes
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:event_id)
    @like_events = Event.find(likes)
  end
end
