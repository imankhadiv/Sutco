Team10MiniProject::Application.routes.draw do
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
