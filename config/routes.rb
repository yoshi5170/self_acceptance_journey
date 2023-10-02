Rails.application.routes.draw do
  resources :self_esteem_trainings, only: %i[new] do
    collection do
      get 'search'
    end
  end
  resource :mypage, only: %i[show]
  resource :garden, only: %i[show]
  root 'static_pages#top'
  get 'top', to:'static_pages#top'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/sign_out", to: "sessions#destroy"
end