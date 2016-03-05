
Rails.application.routes.draw do

  root :to => 'welcome#home'
  
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # devise_for :users, path: "auth", path_names: {
  #              sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
  #              unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
  #            }

  get "categories/view/:slug", :to => "categories#show"
  get "categories",            :to => "categories#home"
  get "categories/:id",        :to => "categories#show"
    
  get "videos/:id",            :to => "categories#video"
  get "video/:legacy_id", :to => "videos#legacy_show"

  namespace :api do
    root :to => 'api#home'

    get 'categories/show/*all',         :to => 'categories#show'
    get 'categories-by-path',           :to => 'categories#index_by_path'
    get 'category-simple-expanded/:id', :to => 'categories#show_simple_expanded'
    get 'category-simple-expanded',     :to => 'categories#show_simple_expanded'
    get 'category/*all',                :to => 'categories#show'
    
    get "categories",                                                           :to => "categories#index_shallow"
    get "categories/:slug",                                                     :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1",                                     :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3",                     :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/page/:videos_page",   :to => "categories#index_shallow"

    get 'videos/in/:category_id',                   :to => 'videos#index'
    get 'videos/in/:category_id/page',              :to => 'videos#index'
    get 'videos/in/:category_id/page/:videos_page', :to => 'videos#index'
    get 'video/:id', :to => 'videos#show_one'
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

    get 'categories/search', :as => :categories_search, :to => 'categories#search'
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
