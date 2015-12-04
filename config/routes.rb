
Rails.application.routes.draw do

  root :to => 'welcome#home'

  resources :categories

  resources :videos

  get 'fighters_guild' => 'fighters_guild/welcome#home', :as => :fg_root
  namespace :fighters_guild, :as => :fg do
    # root :to => 'fighters_guild/welcome#home'
    get "about", :to => "welcome#about"
    resources :merit_badges, :as => :badges
    resources :videos
    post "player_videos/:id", :to => "player_videos#update", :as => :player_video
    resources :questsets
  end

  devise_for :users, controllers: {
               sessions: 'users/sessions'
             }
  # devise_for :users, path: "auth", path_names: {
  #              sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
  #              unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
  #            }

  namespace :manager do
    resources :merit_badges, :as => :badges do
      resources :videos
    end
    resources :users
    resources :questsets do
      resources :videos
    end
    resources :videos
  end


  
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
  
  namespace :manager do
    root :to => 'welcome#home'
  end
  
end
