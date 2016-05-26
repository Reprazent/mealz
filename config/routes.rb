Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    resources :meals, only: [:create, :destroy], defaults: { format: "json" }
    resources :users, only: [:index, :destroy]
  end
end
