Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  put "orders/:id/update_status", to: 'orders#update_status'

  resources :orders, only: [:create, :index, :show]
  resources :specialty_types, only: [:index]
  resources :toppings, only: [:index]
end
