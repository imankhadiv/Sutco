Team10MiniProject::Application.routes.draw do

  root 'calendars#index'
  get "pages/awaiting", as: :awaiting
  get "pages/welcome", as: :welcome

  resources :boards  do
    resources :conversations do
      get :ajax_get_comments
      resources :comments
    end
  end

  devise_for :users,  :controllers => { :registrations => "users/registrations" }
  resources :users do 
    member do
      get :report
    end
  end

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
