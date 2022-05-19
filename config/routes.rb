Rails.application.routes.draw do

  # deviseの初期ルーティング
  devise_for :users

  # ホーム画面のルーティング
  root to: "events#index"

  # 投稿機能とそれに付随する検索機能のルーティング
  resources :events do
    collection do
      get 'search'
    end
  end

  # 一般公開ページのルーティング
  get 'index', to: 'events#event'

  # いいねボタンを押した時にデータを送るためのルーティング
  post 'like/:id' => 'likes#create', as: 'create_like'

  # いいねずみのいいねボタンを押した時にもとあるデータを削除するためのルーティング
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  # ユーザーが投稿したアイテムを表示させるためのルーティングとそれに付随したいいねしたアイテム一覧を表示するためのルーティング
  resources :users, only: :show do
    member do
      get :likes
    end
  end
end

