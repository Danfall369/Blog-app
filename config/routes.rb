Rails.application.routes.draw do
  root 'users#index'
    resources :users do
      resources :posts do
        resources :comments, only: [:create]
        resources :likes, only: [:create]
    end
  end
end