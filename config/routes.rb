Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :solar_users, only: [:index]
      resources :plans, only: [:index]
      resources :saas_members, only: [:index]
    end
  end

  devise_for :solar_users, class_name: 'SolarUser', controllers: {
    sessions: 'solar_users/sessions',
    registrations: 'solar_users/registrations',
    passwords: 'solar_users/passwords',
    confirmations: 'solar_users/confirmations',
    unlocks: 'solar_users/unlocks'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Redirect singular to plural for saas_access_management
  get '/admin/saas_access_management', to: redirect('/admin/saas_access_managements')
  # Redirect singular to plural for saas_sponsored
  get '/admin/saas_sponsored', to: redirect('/admin/saas_sponsoreds')

  resources :solar_companies do
    resources :solar_reviews
    resources :solar_contents
    resources :review_campaigns
  end
  resources :categories
  resources :badges
  resources :posts

  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'
  root 'pages#home'
end
