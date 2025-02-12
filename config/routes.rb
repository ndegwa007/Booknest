# config/routes.rb
Rails.application.routes.draw do
  get "pages/home"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "users/new"
  get "users/create"
  # Authentication routes
  get 'signup', to: 'users#new', as: 'signup' # User registration form
  post 'signup', to: 'users#create' # Create a new user
  get 'login', to: 'sessions#new', as: 'login' # Login form
  post 'login', to: 'sessions#create' # Create a new session (log in)
  delete 'logout', to: 'sessions#destroy', as: 'logout' # Destroy session (log out)

  # Root route
  root 'pages#home' # landing page

  # Books resource.
  resources :books, only: [:index]  # add more actions later
end
