Rails.application.routes.draw do
  resources :beers
  devise_for :users
  use_doorkeeper

  root to: 'static#index'
end
