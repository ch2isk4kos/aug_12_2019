Rails.application.routes.draw do
  resources :players
  resources :rankings
    resources :users
end
