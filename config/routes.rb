Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :solar_users, only: [:index]
      resources :plans, only: [:index]
      resources :saas_members, only: [:index]
    end
  end

  devise_for :solar_users, controllers: {
    sessions: 'solar_users/sessions',
    registrations: 'solar_users/registrations'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  

  resources :solar_companies, param: :slug do
    resources :solar_reviews
    resources :solar_contents
    resources :review_campaigns
  end
  resources :categories, param: :slug do
    resources :subcategories, only: [:show, :index]
  end
  resources :badges
  resources :posts

  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'
  root 'pages#home'
end