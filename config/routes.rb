Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  # devise_for :users
  devise_for :users, controllers: {
      sessions:      'users/sessions',
      registrations: 'users/registrations'
  }
end
