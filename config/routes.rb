Tenkhours::Application.routes.draw do
  resources :home
  resources :users
  resources :charities
  resources :goals
  match '/goals/list/:id', to: 'goals#list', via: :get
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete
  match 'auth/:provider/callback', to: 'sessions#createfb', via: :get
#  resources :users
#  match '/login', to: 'sessions#new', via: :get
#  match '/login_create', to: 'sessions#create', via: :post
#  match '/logout', to: 'sessions#destroy', via: :delete

  root :to => redirect('/home')

end
