Rails.application.routes.draw do

    root 'welcomes#home'                    # get '/', to : 'welcomes#home'

    get 'signup', to: 'users#new'
    post 'signup', to: 'users#create'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'

    delete 'logout', to: 'sessions#destroy'

    resources :categories
    resources :players

    resources :categories do
        resources :rankings, shallow: true  # only: [:index, :new, :create]
    end

    resources :rankings
    resources :users
end
