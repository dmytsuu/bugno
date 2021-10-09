Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users
  resources :projects do
    resources :members
    resource :settings
  end
  resources :assignees
  resources :events
end
