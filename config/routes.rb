Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'api/v1/sessions',
                 registrations: 'api/v1/registrations'
               }
    end
  end

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
