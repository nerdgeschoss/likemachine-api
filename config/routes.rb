Rails.application.routes.draw do
  resources :links, only: [:index, :show, :create, :destroy] do
    resource :like, only: [:create, :destroy]
  end
  resource :sessions, only: [:create, :destroy]

  match "*all" => "application#cors", via: [:options]
  root "application#empty"
end
