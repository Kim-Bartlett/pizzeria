Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :orders, only: [:create, :index, :show, :update]
  resources :specialty_types, only: [:index]
  resources :toppings, only: [:index]
end
