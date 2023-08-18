Rails.application.routes.draw do
  resources :schools do
    resources :batches
    resources :enrollments
  end
  
  resources :courses
  resources :students
  resources :school_admins
  

  get '/home', to: 'dashboards#home', as: :home
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboards#home"

  get '/login' => 'sessions#new', as: :new_login
  post '/login' => 'sessions#create', as: :login_user
  delete '/logout' => 'sessions#destroy', as: :logout_user
end
