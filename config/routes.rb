Rails.application.routes.draw do
  namespace :admin do
    resources :categories, param: :code
    resources :items
    resources :makers, param: :code
    resources :reviews

    post '/import', to: 'home#import'
    root to: 'home#index'
  end

  resources :categories, param: :code, only: :show
  resources :makers, param: :code, only: :show
  resources :items, only: :show
  resources :reviews, only: :create

  get '/search' => 'home#search'
  get '/terms-of-service', to: 'home#terms'
  get '/privacy-policy', to: 'home#privacy'
  get '/specified-commercial', to: 'home#commercial'
  get '/company', to: 'home#company'
  root to: 'home#index'
end
