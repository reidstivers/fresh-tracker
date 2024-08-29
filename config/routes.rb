Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # Route for pantries. user only needs to see their own pantry. Ingredients managed through that pantry.
  resources :ingredients do
    collection do
      get 'expiring', to: 'ingredients#expiring'
      get 'results', to: 'ingredients#results'
      delete 'destroy_results', to: 'ingredients#destroy_results'
      post 'confirm_results', to: 'ingredients#confirm_results'
    end
  end

  resources :shopping_lists, path: 'shoppinglist'
  post 'images/recognize', to: 'images#recognize'

  resources :recipes do
    collection do
      get 'search', to: 'recipe_searches#search'
      get 'result', to: 'recipe_searches#result'
    end
    resources :recipe_ingredients do
      post 'to_ingredients', on: :collection
    end
  end
end
