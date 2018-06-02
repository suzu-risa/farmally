Rails.application.routes.draw do
  get '/' => 'home#index'
  get '/categories/:category_code' => 'category#index'
  get '/items/:id' => 'item#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
