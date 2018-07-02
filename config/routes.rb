Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :items
    resources :makers

    post '/import', to: 'home#import'
    root to: 'home#index'
  end

  resources :categories, param: :category_code, only: :show
  resources :makers, param: :maker_code, only: :show
  resources :items, only: :show

  get '/search' => 'home#search'
  get '/terms-of-service', to: 'home#terms'
  get '/privacy-policy', to: 'home#privacy'
  get '/specified-commercial', to: 'home#commercial'
  get '/company', to: 'home#company'
  root to: 'home#index'
end
