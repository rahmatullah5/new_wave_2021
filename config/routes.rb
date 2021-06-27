# frozen_string_literal: true

Rails.application.routes.draw do
  resources :auth, only: :create
  resources :users do
    namespace :users do
      resources :posts do
        namespace :posts do
          resouces :comments
        end
      end
    end
  end

  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
