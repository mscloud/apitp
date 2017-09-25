Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
             only: [:edit, :update],
             path: 'users',
             controller: 'devise/registrations',
             as: :user_registration
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticate :admin_user do
    mount Que::Web, at: '/que'
  end

  resources :project, only: [:index, :show]
  resources :submissions, only: [:create, :show]

  root to: "project#index"
  
  get '/zero_downtime_check', to: 'application#zero_downtime_check'

  unless Rails.application.config.consider_all_requests_local
    get '*path', to: 'error#not_found', via: :all
  end
end
