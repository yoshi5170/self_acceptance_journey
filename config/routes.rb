Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    get 'dashboards/index'
    root 'dashboards#index'

    resources :unlockable_flowers
    resources :questions

    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
  resources :self_esteem_trainings, only: %i[new] do
    collection do
      get 'search'
    end
  end
  resources :diaries
  resource :mypage, only: %i[show]
  resource :garden, only: %i[show]
  root 'static_pages#top'
  get 'top', to:'static_pages#top'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  resources :questions, only: [:index] do
    collection do
      post :calculate
      get :result
    end
  end
end