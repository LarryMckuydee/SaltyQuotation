Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # get 'relabel/index'

  # get 'shirt_types/index'

  # get 'print_methods/index'

  # get 'customers/index'
  #
  # get 'show_price/:shirt_type_id/:fit_id/:front_print_method_id/:front_block_size_id/:front_block_no/:back_print_method_id/:back_block_size_id/:back_block_no/:left_print_method_id/:left_block_no/:right_print_method_id/:right_block_no/:quantity/:special_print' => 'quotations#show_price'
  get 'what_is_the_time_now'=>'static#server_time'
  get 'show_price'=>'quotations#show_price'
  get 'quotations_in_myr/:id'=>'quotations#show_in_myr', :as => 'quotations_in_myr'
  get 'show_total_cost/:id' => 'quotations#show_total_cost'
  get 'calculator'=>'quotations#calculator'
  # get 'show_cost'=>'quotations#show_cost
  # get 'quotations/show_cost/:shirtid/:fitid/:methodid/:sizeid/:quantity/:noblock' => 'quotations#show_cost'
  # get 'quotations/show_cost/:shirt_type_id/:fit_id/:front_print_method_id/:front_block_size_id/:front_block_no/:back_print_method_id/:back_block_size_id/:back_block_no/:left_print_method_id/:left_block_no/:right_print_method_id/:right_block_no/:quantity/:special_print' => 'quotations#show_cost'
  get 'fits/show'
  # get 'generateform' => 'home#generateform'

  # get 'brands/index'

  resources :quotations
  resources :brands
  resources :shirt_types
  resources :customers
  resources :print_methods
  resources :additional_infos
  resources :relabel

  #get 'home/index'
  root 'home#index'

  # devise_for :apparel_consultants
  devise_for :apparel_consultants, :skip => [:registrations]
  as :apparel_consultant do
    get 'apparel_consultants/edit' => 'devise/registrations#edit', :as => 'edit_apparel_consultant_registration'
    put 'apparel_consultants' => 'devise/registrations#update', :as => 'apparel_consultant_registration'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
