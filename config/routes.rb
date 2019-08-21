Rails.application.routes.draw do

    root 'welcomes#home'

    get 'signup', to: 'users#new'
    post 'signup', to: 'users#create'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'

    delete 'logout', to: 'sessions#destroy'

    resources :categories
    resources :players
    resources :rankings

    resources :categories do
        resources :rankings, shallow: true
    end

    resources :users

    # NOTE: the order of your resources matter
end
