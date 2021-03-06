Rails.application.routes.draw do

  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'},
  :controllers => {:registrations => "registrations"}, :path => '', :path_names => {:edit => 'profile' }
  
  # Home and About
  root 'home#index'
  get 'about' => 'about#index' 

  devise_scope :user do
  
    get "/login" => "devise/sessions#new", :as => :login
    get "/sign_up" => "devise/registrations#new", :as => :sign_up
    get "/profile" => "devise/registrations#edit", :as => :profile
  
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


    resources :users

    resources :ratings

    resources :notifications

    resources :admin

    resources :support
    

    # resources :users do
      resources :courses do
        resources :assignments do
          resources :teams do
            resources :evaluations
        end
      end
    end



    #resources :courses do
     # resources :assignments do
      #  resources :team #do
         # resources :students
        #end
     # end
    #end
      

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
