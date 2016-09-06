Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  root "welcome#index"

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy, :pay, :payment]
  resources :comments, only: [:create]
  resource :task, only: [:create, :update]

  get '/users/payment', to: 'users#payment'

  namespace :student do
    resources :homeworks, only: [:index, :show]
  end

  namespace :teacher do
    resources :students do
      resources :homeworks
    end
  end

end
