CampusCodefest::Application.routes.draw do
  root :to => "home#index"
  resources :events 
  resources :projects do
    resources :project_comments
    resources :project_volunteers
    resources :project_ratings
  end
  
  resources :users
end
