Team10MiniProject::Application.routes.draw do

  root 'calendars#index'
  get "pages/awaiting", as: :awaiting
  get "pages/welcome", as: :welcome

  devise_for :users,  :controllers => { :registrations => "users/registrations" }
  resources :users

  resources :positions

  resources :shows

  resources :calendars

  resources :show_dates do
    resources :fohs, only: [:new, :create, :show]
  end

  resources :fohs, only: [:index]

  resources :trainings do
    member do
      get :attend
      get :get_training_users
    end
  end
  resources :workshops

  resources :show_roles



  resources :socials


end
