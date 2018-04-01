Rails.application.routes.draw do
  
  # get 'sessions/new'

  root "tasks#index"
  resources :subjects do
    resources :tasks
  end
  
  resources :users
  resources :tasks do
    patch :toggle
  end
  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
