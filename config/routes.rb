Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :pokemons, only: %i[index show]
      resources :kinds, only: %i[index show]
    end
  end

  root to: 'api/v1/pokemons#index'
end
