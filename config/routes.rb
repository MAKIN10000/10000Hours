Tenkhours::Application.routes.draw do
  resources :home
  resources :users
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete
  get 'auth/:provider/callback', to: 'sessions#createfb'
#  resources :users
#  match '/login', to: 'sessions#new', via: :get
#  match '/login_create', to: 'sessions#create', via: :post
#  match '/logout', to: 'sessions#destroy', via: :delete

  root :to => redirect('/home')

end
