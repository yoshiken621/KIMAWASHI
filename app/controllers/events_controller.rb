class EventsController < ApplicationController
  # ログイン画面に強制遷移
  before_action :authenticate_user!
  # 検索画面にデータを持たせる
  before_action :set_q, only: [:event, :search]

  # カレンダーに現在ログインしているユーザーの投句したアイテムを表示
  def index
    @events = Event.all.where(user_id: current_user.id)
  end

  # ユーザーが投稿したアイテムを一覧で表示
  def personal
    @events = Event.where(user_id: current_user.id).order('created_at DESC')
  end

  # ユーザーが投稿した中で公開するアイテムの表示
  def event
    @events = Event.order('created_at DESC')
  end

  # 検索画面に表示させるアイテム
  def search
    @results = @q.result.order('created_at DESC')
  end

  
  def new
    @event = Event.new
    @event.date = params[:date] unless params[:date].nil?
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    redirect_to root_path if event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:date, :image, :events_select_id, :met_person, :id, :checkbox).merge(user_id: current_user.id)
  end

  def set_q
    @q = Event.ransack(params[:q])
  end
end
