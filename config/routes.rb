# config/routes.rb
Rails.application.routes.draw do
  # Authentication routes
  get 'signup', to: 'users#new', as: 'signup' # User registration form
  post 'signup', to: 'users#create' # Create a new user
  get 'login', to: 'sessions#new', as: 'login' # Login form
  post 'login', to: 'sessions#create' # Create a new session (log in)
  delete 'logout', to: 'sessions#destroy', as: 'logout' # Destroy session (log out)

  # Root route
  root 'books#index' 
end
