Rails.application.routes.draw do
  Healthcheck.routes(self)

  
  use_doorkeeper

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'registration', to: 'registration#start', defaults: { format: 'json' }
  get 'confirm-registration/:token',
      to: 'registration#continue', defaults: { format: 'json' }
  post 'unlock', to: 'unlock#unlock_profile', defaults: { format: 'json' }
  get 'unlock',
      to: 'unlock#continue', defaults: { format: 'json' }
  post 'confirm-registration',
       to: 'registration#completed', defaults: { format: 'json' }

  post 'password/forgot', to: 'password#forgot', defaults: { format: 'json' }
  post 'password/reset', to: 'password#reset', defaults: { format: 'json' }

  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1 do
      devise_for :users,
                 controllers: { registrations: 'api/v1/users/registrations' },
                 skip: %i[sessions password]

      # devise_for :users, controllers: {
      #     sessions: 'api/v1/users/sessions'
      # }

      devise_for :users,
                 controllers: { confirmations: 'api/v1/users/confirmations' },
                 skip: %i[sessions password]
    end
  end

  namespace :api do
    namespace :v1 do
      jsonapi_resources :users
      get 'all_users', to: 'users#all_users'
      jsonapi_resource :profile
      jsonapi_resources :user_contacts
      jsonapi_resources :accounts
      jsonapi_resources :exercises
      jsonapi_resources :trainings

      get 'destroy_all', to: 'images#destroy_all'
    end
  end
end
