Rails.application.routes.draw do
  root :to => 'welcome#home'
  
  devise_for :users, controllers: { :sessions => 'users/sessions', 
                                    :registrations => 'users/registrations',
                                    :omniauth_callbacks => "omniauth_callbacks"
                                  }
  # devise_for :users, path: "auth", path_names: {
  #              sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
  #              unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
  #            }

  get "categories/view/:slug", :to => "categories#show"
  get "categories",            :to => "categories#home"
  get "categories/:id",        :to => "categories#show"

  get 'donate',                :to => 'welcome#donate'
    
  get "videos/:id",            :to => "categories#video"
  get "video/:legacy_id", :to => "videos#legacy_show"

  namespace :api do
    root :to => 'api#home'

    get 'badges/view/:badgename',     :to => 'badges#show'
    get 'badges/:badgename',          :to => 'badges#show'
    post 'badges/:location_name/buy', :to => 'badges#buy'

    post 'buyStars', :to => 'stars#buy'

    get 'categories/show/*all',         :to => 'categories#show'
    get 'categories-by-path',           :to => 'categories#index_by_path'
    get 'category-simple-expanded/:id', :to => 'categories#show_simple_expanded'
    get 'category-simple-expanded',     :to => 'categories#show_simple_expanded'
    get 'category/*all',                :to => 'categories#show'
    
    get "categories",                                                                       :to => "categories#index_shallow"
    get "categories/:slug",                                                                 :to => "categories#index_shallow"
    get "categories/:slug/:slug_0",                                                         :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1",                                                 :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2",                                         :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3",                                 :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/:slug_4",                         :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/:slug_4/:slug_5",                 :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/:slug_4/:slug_5/:slug_6",         :to => "categories#index_shallow"
    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/:slug_4/:slug_5/:slug_6/:slug_7", :to => "categories#index_shallow"

    get "categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/page/:videos_page",   :to => "categories#index_shallow"

    get 'chapters', :to => 'questpages#index'
    get 'chapters/:slug', :to => 'questpages#show'

    get "locations/:location_name", :to => "questsets#show"
    get "questsets/:id",            :to => "questsets#show"

    post 'users/fb_sign_in',     :to => 'users#fb_sign_in'
    post 'users/profile',        :to => 'users#show'
    post 'users/profile/update', :to => 'users#update'
    get  'users/profile',        :to => 'users#show' # @TODO: only for testing! accessToken must be hidden

    get 'videos/in/:category_id',                   :to => 'videos#index'
    get 'videos/in/:category_id/page',              :to => 'videos#index'
    get 'videos/in/:category_id/page/:videos_page', :to => 'videos#index'
    get 'video/:id',               :to => 'videos#show_one'
    get 'videos/view/:youtube_id', :to => 'videos#show_one'
  end

  
  get 'fighters_guild' => 'fighters_guild/welcome#home', :as => :fg_root
  namespace :fighters_guild, :as => :fg do
    get "about", :to => "welcome#about"

    resources :merit_badges, :as => :badges

    post "player_videos/:id", :to => "player_videos#update", :as => :player_video
    resources :player_videos

    resources :questsets
    resources :questpages, :as => :qp do
      resources :merit_badges
      resources :questsets
    end

    resources :videos
  end

  namespace :manager do
    root :to => 'manager#home'

    get 'categories/search', :as => :categories_search, :to => 'categories#search'
    resources :categories do
      resources :videos
    end

    resources :questpages do
      resources :merit_badges
      resources :questsets
    end
    resources :questsets

    resources :merit_badges, :as => :badges do
      resources :videos
      resources :tasks
    end
    resources :photos
    resources :profiles
    resources :tasks
    resources :users
    resources :questsets do
      resources :videos
    end
    resources :videos do
      resources :tasks do
      end
    end

    get 'sitemap', :to => 'sitemaps#show', :format => :xml
  end

  namespace :technique do
    root :to => "categories#home"
    
    get "categories/view/:slug", :to => "categories#show"
    get "categories",            :to => "categories#home"
    get "categories/:id",        :to => "categories#show"
  end
  
end

