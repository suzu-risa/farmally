Rails.application.routes.draw do
  get '/' => 'home#index'
  get '/categories/:category_code' => 'category#index'
  get '/maker/:maker_code' => 'maker#index'
  get '/items/:id' => 'item#index'
  get '/search' => 'search#index'
end
