Rails.application.routes.draw do
  get '/' => 'home#index'
  get '/categories/:category_code' => 'category#index'
  get '/makers/:maker_code' => 'maker#index'
  get '/search' => 'search#index'

  resources :items, only: :show
end
