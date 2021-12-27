# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  root "pages#index"
end
