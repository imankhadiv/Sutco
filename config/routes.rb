Team10MiniProject::Application.routes.draw do
  resources :applicants

  resources :profiles

  resources :training_attendances

  resources :trainings

  resources :workshop_attendances

  resources :workshops

  resources :fohs

  resources :roles

  resources :shows

  resources :calendars


  root 'pages#welcome'
end
