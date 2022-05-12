class EventsController < ApplicationController
  # ログイン画面に強制遷移
  before_action :authenticate_user!

  # 検索画面にデータを持たせる
  before_action :set_q, only: [:event, :search]

  # 一つのアイテムをデータベースから取得する処理の一括化
  before_action :set_event, only: [:show, :edit, :update, :destroy]

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

  # 新規投稿画面に表示するフォーム
  def new
    @event = Event.new
    @event.date = params[:date] unless params[:date].nil?
  end

  # 新規登録と完了後の一覧への遷移
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  # 詳細ページに表示するアイテム
  def show
  end

  # 編集画面に表示するフォーム
  def edit
  end

  # 編集画面からの更新と完了後の一覧への遷移
  def update
    if @event.update(event_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  # 投稿済みアイテムの削除
  def destroy
    redirect_to root_path if @event.destroy
  end

  private

  # 投稿フォームからデータベースに送られる情報の選別
  def event_params
    params.require(:event).permit(:date, :image, :events_select_id, :met_person, :id, :checkbox).merge(user_id: current_user.id)
  end

  # 検索画面に表示するアイテム
  def set_q
    @q = Event.ransack(params[:q])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
