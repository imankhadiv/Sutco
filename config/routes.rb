Team10MiniProject::Application.routes.draw do


  resources :boards  do
    resources :conversations do
      resources :comments
    end
  end

  resources :roles

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
    collection do
      put :record_attendance

    end
    end

  resources :workshops do
    member do
      get :attend
      get :attendee
    end
    collection do
      put :record_attendance

    end
  end


  resources :show_roles do
    resources :role_applications, only: [:new, :create, :show]
  end
  resources :role_applications

  resources :socials


end
