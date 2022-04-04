# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root to: 'routines#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :exercises
  resources :routines
end
