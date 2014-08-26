CampusCodefest::Application.routes.draw do
  # Non-org routes
  root :to => "home#index", constraints: lambda { |r| !r.subdomain.present? || r.subdomain == 'www' }
  match "about" => "home#about", constraints: lambda { |r| !r.subdomain.present? || r.subdomain == 'www' }
  match "faq" => "home#faq", constraints: lambda { |r| !r.subdomain.present? || r.subdomain == 'www' }
  match "github" => "home#github", constraints: lambda { |r| !r.subdomain.present? || r.subdomain == 'www' }

  # Shared routes
  resources :organizations
  resources :users do
    member do
      post :deactivate
    end
  end
  resource :session

  namespace :super_admin do
    root to: "home#index"
    resources :users do
      collection do
        get :search
      end
    end

    resources :organizations do
      collection do
        get :search
      end
    end
  end

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#signout", :as => :signout

  # Organization routes
  root :to => "organization_home#index", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  match "unverified" => "organization_home#unverified", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  resources :events, constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    resources :event_registrations
  end

  resource :organization_users, only: [:create]#, constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  resources :projects, constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    member do
      post :rate
      post :volunteer
      post :unvolunteer
      get :present
    end

    resources :project_comments
  end

  namespace :admin, constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    root :to => 'home#index'
    resource :organization
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

    resources :projects
  end
end
