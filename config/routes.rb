CampusCodefest::Application.routes.draw do
  root :to => "home#index"
  resources :events 
  resources :projects do
    resources :project_comments
    resources :project_volunteers
    resources :project_ratings
  end
  
  resources :users
  resource :session
  
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#signout", :as => :signout  
  
  namespace :admin do
    root :to => 'home#index'
    resources :users
    resources :events
  end  
end
