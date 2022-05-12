class LikesController < ApplicationController
  before_action :event_params

  # いいねの個数の追加処理
  def create
    Like.create(user_id: current_user.id, event_id: params[:id])
  end

  # いいねの個数の削除処理
  def destroy
    Like.find_by(user_id: current_user.id, event_id: params[:id]).destroy
  end

  private

  # いいねを付与する先のアイテムの指定
  def event_params
    @event = Event.find(params[:id])
  end
end
