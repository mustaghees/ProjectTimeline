Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    unlocks:  'admins/unlocks'
  }

  get :admin,               to: 'admins/admins#show'
  get 'admin/projects',     to: 'admins/admins#show'
  get 'admin/categories',   to: 'admins/admins#categories'
  get 'admin/technologies', to: 'admins/admins#technologies'
  get 'admin/contributors', to: 'admins/admins#contributors'

  resources :projects,     only: [:index, :show, :create, :update, :destroy]
  resources :contributors, only: [:index, :show]
  resources :technologies, only: [:edit,  :update, :destroy]

  root 'projects#index'
end
