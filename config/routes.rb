# config/routes.rb
Rails.application.routes.draw do
  get "books/index"
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

  # Books routes
  resources :books, only: [:index]  do # add more actions later
    post 'borrow', on: :member
  end

  # Users routes
  resources :users do
    member do
      delete 'return_book/:book_id', to: 'users#return_book', as: :return_book
      get 'borrowed_books'
    end
  end
end
