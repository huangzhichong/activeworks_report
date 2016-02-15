Rails.application.routes.draw do
  resources :sprints
  resources :task_types
  resources :tasks
  resources :projects
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get 'show_sprint_summary/:sprint_id',:controller => 'projects', :action => 'show_sprint_summary'

end
