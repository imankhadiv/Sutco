Team10MiniProject::Application.routes.draw do

  resources :positions

  resources :show_dates do
    resources :fohs
  end

  devise_for :users,  :controllers => { :registrations => "users/registrations" }

  resources :trainings do
    member do
      get :attend
      get :get_training_users
    end
  end

  resources :workshops

  resources :users

  #resources :fohs

  resources :show_roles

  resources :shows

  resources :calendars

  resources :socials

  get "pages/awaiting"
  get "pages/welcome"
  root 'calendars#index'
end
