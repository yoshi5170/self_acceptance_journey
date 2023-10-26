Rails.application.routes.draw do
  namespace :admin do
    get 'dashboards/index'
    root 'dashboards#index'

    resources :unlockable_flowers, only: %i[index new create destroy]
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
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/sign_out", to: "sessions#destroy"
  resources :questions, only: [:index] do
    collection do
      post :calculate
      get :result
    end
  end
end