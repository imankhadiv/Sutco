Team10MiniProject::Application.routes.draw do

  resources :training_attendances

  resources :trainings

  resources :workshop_attendances

  resources :workshops

  resources :fohs

  resources :roles

  resources :shows

  resources :calendars

  resources :socials

  root 'pages#welcome'
end
