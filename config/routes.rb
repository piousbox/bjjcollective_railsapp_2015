
Rails.application.routes.draw do

  root :to => 'welcome#home'
  
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # devise_for :users, path: "auth", path_names: {
  #              sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
  #              unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
  #            }

  get "categories/view/:slug", :to => "categories#show"
  resources :categories
  resources :videos

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
  
end
