
Rails.application.routes.draw do

  root :to => 'technique/categories#home'
  
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # devise_for :users, path: "auth", path_names: {
  #              sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
  #              unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
  #            }
  
  get "videos/:id",            :to => "categories#video"
  get "video/:legacy_id", :to => "videos#legacy_show"

  namespace :api do
    get "categories", :to => "categories#index_shallow"
    
    resources :categories
    
  end
  
  get 'fighters_guild' => 'fighters_guild/welcome#home', :as => :fg_root
  namespace :fighters_guild, :as => :fg do
    # root :to => 'fighters_guild/welcome#home'
    get "about", :to => "welcome#about"
    resources :merit_badges, :as => :badges
    post "player_videos/:id", :to => "player_videos#update", :as => :player_video
    resources :player_videos
    resources :questsets
    resources :videos
  end

  namespace :manager do
    root :to => 'welcome#home'
    resources :categories do
    end
    resources :merit_badges, :as => :badges do
      resources :videos
    end
    resources :photos
    resources :tasks
    resources :users
    resources :questsets do
      resources :videos
    end
    resources :videos do
      resources :tasks do
      end
    end
  end

  namespace :technique do
    root :to => "categories#home"
    
    get "categories/view/:slug", :to => "categories#show"
    get "categories",            :to => "categories#home"
    get "categories/:id",        :to => "categories#show"
  end
  
end
