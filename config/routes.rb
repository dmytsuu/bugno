require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root 'projects#index'
  devise_for :users
  resources :projects do
    resources :members
    resource :settings
  end
  resources :assignees
  resources :events
  post 'api/v1/projects/:project_id/events', to: 'api/v1/events#create'
end
