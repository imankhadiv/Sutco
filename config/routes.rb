Team10MiniProject::Application.routes.draw do

  devise_for :users,  :controllers => { :registrations => "users/registrations" }

  resources :training_attendances

  resources :trainings

  resources :workshop_attendances

  resources :workshops

  resources :users

  resources :fohs

  resources :show_roles

  resources :shows

  resources :calendars

  resources :socials

  get "pages/awaiting"

  root 'pages#welcome'
end
