Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  root "welcome#index"

  resource :session, only: [:new, :create, :destroy]
  resource :user, only: [:new, :create, :destroy]

  namespace :student do
    resources :homeworks, only: [:index, :show, :update]
  end

  namespace :teacher do
    resources :students do
      resources :homeworks
    end
  end

end
