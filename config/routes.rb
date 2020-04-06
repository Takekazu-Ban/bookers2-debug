Rails.application.routes.draw do
  #devise_for :homes

  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'sign_up/:id' => 'devise/registrations#new'
  #get 'sign_in/:id' => 'devise/sessions#new'

  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
      resource :favorites, only: [:create, :destroy]
      resource :book_comments, only: [:create, :destroy]
  end

end