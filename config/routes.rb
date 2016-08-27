Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'static#index'

  namespace 'api' do
    resources :beers
  end
end
