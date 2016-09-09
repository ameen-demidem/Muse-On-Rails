Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy]
  resources :comments, only: [:create]
  resource :task, only: [:create, :update]

  get '/users/payment', to: 'users#payment'
  post '/users/pay', to: 'users#pay'

  get '/connect/oauth' => 'stripe#oauth', as: 'stripe_oauth'
  get '/connect/confirm' => 'stripe#confirm', as: 'stripe_confirm'
  get '/connect/deauthorize' => 'stripe#deauthorize', as: 'stripe_deauthorize'

  namespace :student do
    resources :homeworks, only: [:index, :show]
    resources :lessons
  end

  namespace :parent do
    resources :children, only: [:index] do
      resources :homeworks, only: [:index, :show]
    end
    resources :lessons
  end

  namespace :teacher do
    resources :students do
      resources :homeworks
      collection do
        get '/archived_students', action: :archived_students
      end
    end
    resources :lessons
  end

end
