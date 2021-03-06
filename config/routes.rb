Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/estudiante', to: 'estudiante#index'
  get 'static/home'
  get 'error/show'
  get 'error/no_disponible'
  get 'error/no_permiso'
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}, :skip => [:sessions, :registrations, :passwords]
  as :user do
    get "/users/sign_in" => "error#no_permiso", :as => :new_user_session
    post "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end 
  resources :users, :only => [:edit, :update]
  get 'asignaturas/copy', to: 'asignaturas#copy'
  resources :asignaturas, :except => [:destroy] do
    resources :qcds do
      get '/answergroups/grupal' => 'answergroups#grupal' 
      resources :answergroups, :only => [:new, :create]
    end
  end
  root to: 'static#home'
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
