Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users
  resources :projects
  resources :project_users
  resources :events
end
