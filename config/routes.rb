Rails.application.routes.draw do

    root 'welcomes#home'

    get 'signup', to: 'users#new'
    post 'signup', to: 'users#create'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'

    get 'auth/:provider/callback', to: 'sessions#google_auth'

    delete 'logout', to: 'sessions#destroy'

    resources :users

    resources :categories
    resources :rankings

    resources :categories do
        resources :rankings, shallow: true
    end

    resources :players

    # NOTE: the order of your resources matter
end
