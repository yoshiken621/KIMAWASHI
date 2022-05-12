Rails.application.routes.draw do
  devise_for :users
  root to: "events#index"
  resources :events do
    collection do
      get 'search'
    end
  end
  get 'index', to: 'events#event'
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :users, only: :show do
    member do
      get :likes
    end
  end
end

