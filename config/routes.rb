Rails.application.routes.draw do
  #devise_for :homes

  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'sign_up/:id' => 'devise/registrations#new'
  get 'follow_user' => 'users#follow_user'
  get 'follower_user' => 'users#follower_user'
  #get 'sign_in/:id' => 'devise/sessions#new'

  resources :users,only: [:show,:index,:edit,:update]
  resources :relationships, only: [:create, :destroy]

  resources :books do
      resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
  end

end