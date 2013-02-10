RentifyAdmin::Application.routes.draw do

  get "sites/index"

  resources :login, :only => [:index]
  resources :home, :only => [:index]

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure", to: "sessions#failure"

  resource :session do
    get :new, :path => 'sign_in', :as => "new"
    get :destroy, :path => 'sign_out', :as => "destroy"
  end

  resources :registration, :only => [:new, :create]

  resources :sites
  resources :properties do
    resources :calendars,  controller: 'properties/calendars'
    resources :photos,     controller: 'properties/photos'
    resources :articles,   controller: 'properties/articles'
    resources :directions, controller: 'properties/directions', only: [:index, :new, :create]
  end
  resources :dashboard,  :only => [:index]

  root :to => 'home#index'

end
