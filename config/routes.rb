Rails.application.routes.draw do
  devise_for :homes

  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#show'
  get 'sign_up/:id' => 'devise/registrations#new'

  resources :users,only: [:show,:index,:edit,:update]
  resources :books



end