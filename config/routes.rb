Rails.application.routes.draw do
  resources :sprints
  resources :task_types
  resources :tasks
  resources :projects do
    resources :sprints
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get 'show_sprint_summary/:sprint_id',:controller => 'projects', :action => 'show_sprint_summary'

end
