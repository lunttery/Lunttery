Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :shops do
    resources :meals do
      member do
        post :change_favorite
      end
    end

    collection do
      get :search
    end
  end

  namespace :admin do
    resources :tags
  end

  root to: 'shops#index'
end
