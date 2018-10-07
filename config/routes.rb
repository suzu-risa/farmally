Rails.application.routes.draw do
  mount_roboto
  namespace :admin do
    resources :categories, param: :code
    resources :items
    resources :makers, param: :code
    resources :reviews
    resources :review_comments

    post '/import', to: 'home#import'
    put '/sitemap', to: 'home#sitemap'
    root to: 'home#index'
  end

  resources :categories, param: :code, only: :show
  resources :makers, param: :code, only: :show
  resources :items, only: :show do
    resources :reviews, only: :new
  end
  resources :reviews, only: :create do
    member do
      post :likes
    end
    resources :review_comments, only: :new
  end
  resources :review_comments, only: :create do
    member do
      post :likes
    end
  end
  resources :forms, only: :create

  get '/search' => 'home#search'
  # get '/terms-of-service', to: 'home#terms'
  # get '/privacy-policy', to: 'home#privacy'
  # get '/specified-commercial', to: 'home#commercial'
  # get '/company', to: 'home#company'
  get '/terms-of-service', to: 'home#index'
  get '/privacy-policy', to: 'home#index'
  get '/specified-commercial', to: 'home#index'
  get '/company', to: 'home#index'
  get '/form', to: 'home#form'
  get '/sell-form', to: 'home#sell_form'
  root to: 'home#index'
end
