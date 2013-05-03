RentifyAdmin::Application.routes.draw do


  get '/app', :to => 'app#index'
  get '/app/*foo', :to => 'app#index'

  namespace 'api' do
    get "registration/send_again"
    resources :sites,        controller: 'sites',                 only: [ :index, :show, :new, :create, :update ]
    resources :addresses,    controller: 'addresses',             only: [ :show ]
    resources :identities,   controller: 'identities',            only: [ :create ]
    resources :feeds,        controller: 'feeds',                 only: [ :index, :destroy ]
    resources :properties,   controller: 'properties',            only: [ :index, :show, :new, :create, :update ] do
      resources :calendars,  controller: 'properties/calendars',  only: [ :new, :create, :update ]
      resources :articles,   controller: 'properties/articles',   only: [ :new, :create, :update ]
      resources :directions, controller: 'properties/directions', only: [ :new, :create, :update ]
      resources :photos,     controller: 'properties/photos',     only: [ :index, :create, :destroy ]
    end
  end

  resources :login, only: [:index]
  resources :home, only: [:index]

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure", to: "sessions#failure"

  resource :session do
    get :new, path: 'sign_in', as: "new"
    get :destroy, path: 'sign_out', as: "destroy"
  end

  resources :registration, only: [:new, :create, :destroy] do
    member do
      get 'verify'
    end
  end

  resources :accounts, only: [:edit, :update]

  resource :password, only: [:edit, :update] do
    member do
      get 'forgot'
      post 'requested'
      get 'sent'
    end
  end

  root :to => 'home#index'

end
