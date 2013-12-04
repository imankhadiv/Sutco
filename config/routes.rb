Team10MiniProject::Application.routes.draw do
  devise_for :users
  resources :applicants

  resources :profiles

  resources :training_attendances

  resources :trainings

  resources :workshop_attendances

  resources :workshops

  resources :fohs

  resources :roles

  resources :shows

  root 'pages#welcome'
end
