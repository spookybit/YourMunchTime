Rails.application.routes.draw do
  root to: 'static_pages#root'

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create]
    resource :session, only: [:create, :destroy]
    resources :restaurants, only: [:index, :create, :show] do
      resources :reviews, only: [:show, :create]
    end
    resources :locations, only: [:index, :show]

    # resources :favorites
  end
end
