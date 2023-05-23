require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root 'projects#index'
  devise_for :users
  resources :mobile_projects
  resources :projects do
    resources :members
    resource :settings
    resource :preferences
  end
  resources :assignees
  resources :events do
    resource :request_params, only: :show
    resource :gpt, only: :show
    # resources :occurrences
  end
  resources :event_collections, only: :destroy
  resource :helps
  post 'api/v1/projects/:project_id/events', to: 'api/v1/events#create'
end
