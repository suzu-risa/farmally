Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :items
    resources :makers

    post '/import', to: 'home#import'
    root to: 'home#index'
  end

  get '/categories/:category_code' => 'category#index'
  get '/makers/:maker_code' => 'maker#index'
  get '/search' => 'search#index'

  resources :items, only: :show
  root to: 'home#index'
end
