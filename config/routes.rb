Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    devise_scope :user do
      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end

    resources :dashboards, only: %i[index]
    root 'dashboards#index'

    resources :unlockable_flowers
    resources :questions
  end

  resources :self_esteem_trainings, only: %i[new] do
    collection do
      get 'result'
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