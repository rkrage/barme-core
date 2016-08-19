Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  root to: 'static#index'

  namespace 'api' do
    resources :beers
  end
end
