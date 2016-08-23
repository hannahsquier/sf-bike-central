Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "maps#show"

  post "login" => "sessions#create"

  get "logout" => "sessions#destroy"

  resources :users
  resources :incidents

end
