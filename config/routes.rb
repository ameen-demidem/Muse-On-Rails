Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy]
  resources :comments, only: [:create]
  resource :task, only: [:create, :update]

  namespace :student do
    resources :homeworks, only: [:index, :show]
    resources :lessons
  end

  namespace :parent do
    resources :children, only: [:index] do
      resources :homeworks, only: [:index, :show]
    end
  end

  namespace :teacher do
    resources :students do
      resources :homeworks
    end
    resources :lessons
  end

end
