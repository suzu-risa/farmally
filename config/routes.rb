Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount_roboto
  namespace :admin do
    resources :categories, param: :code
    resources :sub_categories
    resources :items do
      collection do
        get :export
      end
    end
    resources :makers, param: :code
    resources :reviews
    resources :review_comments
    resources :staffs
    resources :sale_items do
      scope module: :sale_items do
        resources :images, only: [:create, :destroy] do
          collection do
            patch :bulk_update
          end
        end
      end

      resources :sale_item_inquiries, as: :inquiries
    end
    resources :sale_item_templates do
      member do
        get :detail_file
      end
    end

    resources :item_market_prices

    post '/import', to: 'home#import'
    put '/sitemap', to: 'home#sitemap'
    root to: 'home#index'
  end

  resources :items, only: [:index] do
    get :images
  end
  get '/items/categories/:code', to: 'items#index'

  resources :sell, only: [:index, :create]
  get '/sell/categories' => 'sell#categories'
  get '/sell/categories/:category_slug' => 'sell#show_category'
  get '/sell-call-click' => 'sell#call_click_log'

  resources :inquiry, only: [:index, :create]

  get '/buy/:item_id', to: 'buy#index', as: 'buy'
  get '/buy/create', to: 'buy#create'
  post '/buy/:item_id', to: 'buy#create'

  get '/specified-commercial', to: 'home#commercial'
  get '/sitemap', to: redirect('https://s3-ap-northeast-1.amazonaws.com/jp.farmally.sitemap/sitemap.xml.gz')

  root to: 'home#index'
end

# == Route Map
#                               Prefix Verb   URI Pattern                                                                              Controller#Action
#                             ckeditor        /ckeditor                                                                                Ckeditor::Engine
#                               roboto        /robots.txt                                                                              Roboto::Engine
#                     admin_categories GET    /admin/categories(.:format)                                                              admin/categories#index
#                                      POST   /admin/categories(.:format)                                                              admin/categories#create
#                   new_admin_category GET    /admin/categories/new(.:format)                                                          admin/categories#new
#                  edit_admin_category GET    /admin/categories/:code/edit(.:format)                                                   admin/categories#edit
#                       admin_category GET    /admin/categories/:code(.:format)                                                        admin/categories#show
#                                      PATCH  /admin/categories/:code(.:format)                                                        admin/categories#update
#                                      PUT    /admin/categories/:code(.:format)                                                        admin/categories#update
#                                      DELETE /admin/categories/:code(.:format)                                                        admin/categories#destroy
#                 admin_sub_categories GET    /admin/sub_categories(.:format)                                                          admin/sub_categories#index
#                                      POST   /admin/sub_categories(.:format)                                                          admin/sub_categories#create
#               new_admin_sub_category GET    /admin/sub_categories/new(.:format)                                                      admin/sub_categories#new
#              edit_admin_sub_category GET    /admin/sub_categories/:id/edit(.:format)                                                 admin/sub_categories#edit
#                   admin_sub_category GET    /admin/sub_categories/:id(.:format)                                                      admin/sub_categories#show
#                                      PATCH  /admin/sub_categories/:id(.:format)                                                      admin/sub_categories#update
#                                      PUT    /admin/sub_categories/:id(.:format)                                                      admin/sub_categories#update
#                                      DELETE /admin/sub_categories/:id(.:format)                                                      admin/sub_categories#destroy
#                   export_admin_items GET    /admin/items/export(.:format)                                                            admin/items#export
#                          admin_items GET    /admin/items(.:format)                                                                   admin/items#index
#                                      POST   /admin/items(.:format)                                                                   admin/items#create
#                       new_admin_item GET    /admin/items/new(.:format)                                                               admin/items#new
#                      edit_admin_item GET    /admin/items/:id/edit(.:format)                                                          admin/items#edit
#                           admin_item GET    /admin/items/:id(.:format)                                                               admin/items#show
#                                      PATCH  /admin/items/:id(.:format)                                                               admin/items#update
#                                      PUT    /admin/items/:id(.:format)                                                               admin/items#update
#                                      DELETE /admin/items/:id(.:format)                                                               admin/items#destroy
#                         admin_makers GET    /admin/makers(.:format)                                                                  admin/makers#index
#                                      POST   /admin/makers(.:format)                                                                  admin/makers#create
#                      new_admin_maker GET    /admin/makers/new(.:format)                                                              admin/makers#new
#                     edit_admin_maker GET    /admin/makers/:code/edit(.:format)                                                       admin/makers#edit
#                          admin_maker GET    /admin/makers/:code(.:format)                                                            admin/makers#show
#                                      PATCH  /admin/makers/:code(.:format)                                                            admin/makers#update
#                                      PUT    /admin/makers/:code(.:format)                                                            admin/makers#update
#                                      DELETE /admin/makers/:code(.:format)                                                            admin/makers#destroy
#                        admin_reviews GET    /admin/reviews(.:format)                                                                 admin/reviews#index
#                                      POST   /admin/reviews(.:format)                                                                 admin/reviews#create
#                     new_admin_review GET    /admin/reviews/new(.:format)                                                             admin/reviews#new
#                    edit_admin_review GET    /admin/reviews/:id/edit(.:format)                                                        admin/reviews#edit
#                         admin_review GET    /admin/reviews/:id(.:format)                                                             admin/reviews#show
#                                      PATCH  /admin/reviews/:id(.:format)                                                             admin/reviews#update
#                                      PUT    /admin/reviews/:id(.:format)                                                             admin/reviews#update
#                                      DELETE /admin/reviews/:id(.:format)                                                             admin/reviews#destroy
#                admin_review_comments GET    /admin/review_comments(.:format)                                                         admin/review_comments#index
#                                      POST   /admin/review_comments(.:format)                                                         admin/review_comments#create
#             new_admin_review_comment GET    /admin/review_comments/new(.:format)                                                     admin/review_comments#new
#            edit_admin_review_comment GET    /admin/review_comments/:id/edit(.:format)                                                admin/review_comments#edit
#                 admin_review_comment GET    /admin/review_comments/:id(.:format)                                                     admin/review_comments#show
#                                      PATCH  /admin/review_comments/:id(.:format)                                                     admin/review_comments#update
#                                      PUT    /admin/review_comments/:id(.:format)                                                     admin/review_comments#update
#                                      DELETE /admin/review_comments/:id(.:format)                                                     admin/review_comments#destroy
#                         admin_staffs GET    /admin/staffs(.:format)                                                                  admin/staffs#index
#                                      POST   /admin/staffs(.:format)                                                                  admin/staffs#create
#                      new_admin_staff GET    /admin/staffs/new(.:format)                                                              admin/staffs#new
#                     edit_admin_staff GET    /admin/staffs/:id/edit(.:format)                                                         admin/staffs#edit
#                          admin_staff GET    /admin/staffs/:id(.:format)                                                              admin/staffs#show
#                                      PATCH  /admin/staffs/:id(.:format)                                                              admin/staffs#update
#                                      PUT    /admin/staffs/:id(.:format)                                                              admin/staffs#update
#                                      DELETE /admin/staffs/:id(.:format)                                                              admin/staffs#destroy
#   bulk_update_admin_sale_item_images PATCH  /admin/sale_items/:sale_item_id/images/bulk_update(.:format)                             admin/sale_items/images#bulk_update
#               admin_sale_item_images POST   /admin/sale_items/:sale_item_id/images(.:format)                                         admin/sale_items/images#create
#                admin_sale_item_image DELETE /admin/sale_items/:sale_item_id/images/:id(.:format)                                     admin/sale_items/images#destroy
#            admin_sale_item_inquiries GET    /admin/sale_items/:sale_item_id/sale_item_inquiries(.:format)                            admin/sale_item_inquiries#index
#                                      POST   /admin/sale_items/:sale_item_id/sale_item_inquiries(.:format)                            admin/sale_item_inquiries#create
#          new_admin_sale_item_inquiry GET    /admin/sale_items/:sale_item_id/sale_item_inquiries/new(.:format)                        admin/sale_item_inquiries#new
#         edit_admin_sale_item_inquiry GET    /admin/sale_items/:sale_item_id/sale_item_inquiries/:id/edit(.:format)                   admin/sale_item_inquiries#edit
#              admin_sale_item_inquiry GET    /admin/sale_items/:sale_item_id/sale_item_inquiries/:id(.:format)                        admin/sale_item_inquiries#show
#                                      PATCH  /admin/sale_items/:sale_item_id/sale_item_inquiries/:id(.:format)                        admin/sale_item_inquiries#update
#                                      PUT    /admin/sale_items/:sale_item_id/sale_item_inquiries/:id(.:format)                        admin/sale_item_inquiries#update
#                                      DELETE /admin/sale_items/:sale_item_id/sale_item_inquiries/:id(.:format)                        admin/sale_item_inquiries#destroy
#                     admin_sale_items GET    /admin/sale_items(.:format)                                                              admin/sale_items#index
#                                      POST   /admin/sale_items(.:format)                                                              admin/sale_items#create
#                  new_admin_sale_item GET    /admin/sale_items/new(.:format)                                                          admin/sale_items#new
#                 edit_admin_sale_item GET    /admin/sale_items/:id/edit(.:format)                                                     admin/sale_items#edit
#                      admin_sale_item GET    /admin/sale_items/:id(.:format)                                                          admin/sale_items#show
#                                      PATCH  /admin/sale_items/:id(.:format)                                                          admin/sale_items#update
#                                      PUT    /admin/sale_items/:id(.:format)                                                          admin/sale_items#update
#                                      DELETE /admin/sale_items/:id(.:format)                                                          admin/sale_items#destroy
# detail_file_admin_sale_item_template GET    /admin/sale_item_templates/:id/detail_file(.:format)                                     admin/sale_item_templates#detail_file
#            admin_sale_item_templates GET    /admin/sale_item_templates(.:format)                                                     admin/sale_item_templates#index
#                                      POST   /admin/sale_item_templates(.:format)                                                     admin/sale_item_templates#create
#         new_admin_sale_item_template GET    /admin/sale_item_templates/new(.:format)                                                 admin/sale_item_templates#new
#        edit_admin_sale_item_template GET    /admin/sale_item_templates/:id/edit(.:format)                                            admin/sale_item_templates#edit
#             admin_sale_item_template GET    /admin/sale_item_templates/:id(.:format)                                                 admin/sale_item_templates#show
#                                      PATCH  /admin/sale_item_templates/:id(.:format)                                                 admin/sale_item_templates#update
#                                      PUT    /admin/sale_item_templates/:id(.:format)                                                 admin/sale_item_templates#update
#                                      DELETE /admin/sale_item_templates/:id(.:format)                                                 admin/sale_item_templates#destroy
#             admin_item_market_prices GET    /admin/item_market_prices(.:format)                                                      admin/item_market_prices#index
#                                      POST   /admin/item_market_prices(.:format)                                                      admin/item_market_prices#create
#          new_admin_item_market_price GET    /admin/item_market_prices/new(.:format)                                                  admin/item_market_prices#new
#         edit_admin_item_market_price GET    /admin/item_market_prices/:id/edit(.:format)                                             admin/item_market_prices#edit
#              admin_item_market_price GET    /admin/item_market_prices/:id(.:format)                                                  admin/item_market_prices#show
#                                      PATCH  /admin/item_market_prices/:id(.:format)                                                  admin/item_market_prices#update
#                                      PUT    /admin/item_market_prices/:id(.:format)                                                  admin/item_market_prices#update
#                                      DELETE /admin/item_market_prices/:id(.:format)                                                  admin/item_market_prices#destroy
#                         admin_import POST   /admin/import(.:format)                                                                  admin/home#import
#                        admin_sitemap PUT    /admin/sitemap(.:format)                                                                 admin/home#sitemap
#                           admin_root GET    /admin(.:format)                                                                         admin/home#index
#                          item_images GET    /items/:item_id/images(.:format)                                                         items#images
#                                items GET    /items(.:format)                                                                         items#index
#                                      GET    /items/categories/:code(.:format)                                                        items#index
#                           sell_index GET    /sell(.:format)                                                                          sell#index
#                                      POST   /sell(.:format)                                                                          sell#create
#                      sell_categories GET    /sell/categories(.:format)                                                               sell#categories
#                                      GET    /sell/categories/:category_slug(.:format)                                                sell#show_category
#                      sell_call_click GET    /sell-call-click(.:format)                                                               sell#call_click_log
#                        inquiry_index GET    /inquiry(.:format)                                                                       inquiry#index
#                                      POST   /inquiry(.:format)                                                                       inquiry#create
#                                  buy GET    /buy/:item_id(.:format)                                                                  buy#index
#                           buy_create GET    /buy/create(.:format)                                                                    buy#create
#                                      POST   /buy/:item_id(.:format)                                                                  buy#create
#                 specified_commercial GET    /specified-commercial(.:format)                                                          home#commercial
#                              sitemap GET    /sitemap(.:format)                                                                       redirect(301, https://s3-ap-northeast-1.amazonaws.com/jp.farmally.sitemap/sitemap.xml.gz)
#                                 root GET    /                                                                                        home#index
#                   rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#            rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                   rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#            update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                 rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
# 
# Routes for Ckeditor::Engine:
#         pictures GET    /pictures(.:format)             ckeditor/pictures#index
#                  POST   /pictures(.:format)             ckeditor/pictures#create
#          picture DELETE /pictures/:id(.:format)         ckeditor/pictures#destroy
# attachment_files GET    /attachment_files(.:format)     ckeditor/attachment_files#index
#                  POST   /attachment_files(.:format)     ckeditor/attachment_files#create
#  attachment_file DELETE /attachment_files/:id(.:format) ckeditor/attachment_files#destroy
# 
# Routes for Roboto::Engine:
#        GET  /           roboto/robots#show
