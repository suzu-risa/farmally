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
  get '/terms-of-service', to: 'home#terms'
  get '/privacy-policy', to: 'home#privacy'
  get '/specified-commercial', to: 'home#commercial'
  get '/company', to: 'home#company'
  root to: 'home#index'
end
