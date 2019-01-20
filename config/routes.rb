Rails.application.routes.draw do
     resources :users

     get 'sessions/new'
     root "top#index"

     get    'users'  => 'users#index'
     get    'user'  => 'users#other'
     get    'signup'  => 'users#new'
     get    'login'   => 'sessions#new'
     post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
     end
