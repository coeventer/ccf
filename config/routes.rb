CampusCodefest::Application.routes.draw do
  root :to => "home#index"
  match "about" => "home#about"
  match "contact" => "home#contact"  
  match "unverified" => "home#unverified"

  resources :events do
    resources :event_registrations
  end

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
    resources :users do
      collection do
        get :search
      end
    end
    resources :events do
      resources :event_moderators
      resources :event_registrations
      
      resources :projects do
        resources :project_volunteers
        resources :project_comments
        resources :project_votes
      end
      
    end
  end  
end
