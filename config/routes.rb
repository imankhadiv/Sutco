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
      get :attendee
    end
  end
  resources :workshops do
    member do
      get :attend
      get :attendee
    end
  end

  resources :show_roles



  resources :socials


end
