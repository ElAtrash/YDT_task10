Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      get '/users', to: 'users#home'
      resources :users, only: [:home]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :teams do
        resources :users
      end
    end  
  end

  root 'api/v1/users#home'
end
