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

  resources :sites
  resources :properties do
    resources :calendars
    resources :photos, controller: 'properties/photos'
  end
  resources :dashboard,  :only => [:index]


  root :to => 'home#index'

end
