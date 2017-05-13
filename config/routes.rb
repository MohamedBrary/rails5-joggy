Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    %w(v1).each do |version|
      namespace version.to_sym do
        resources :users, only: %w(index create update show destroy) do
          collection do
            post :forgot_password
            put :reset_password
          end
        end
        resource :user_token, path: :token, only: %w(create destroy)
      end
    end
  end
  

  devise_for :users, :controllers => { 
    omniauth_callbacks: 'omniauth_callbacks',
    registrations: 'registrations',
    sessions: 'sessions',
    passwords: 'passwords'
  }
  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end
  resources :users, except: [:new, :create]

  get 'home/index'
  root "home#index"  
end
