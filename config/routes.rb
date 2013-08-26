CampusCodefest::Application.routes.draw do
  root :to => "home#index"
  resources :events 
  resources :projects do
    member do
      post :rate
      post :volunteer
      post :unvolunteer
    end
    resources :project_comments
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
