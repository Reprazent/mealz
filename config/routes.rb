Rails.application.routes.draw do
  namespace :api, constraints: { format: :json }  do
    resources :meals, only: [:create], defaults: { format: "json" }
    resources :users, only: [:index]
  end
end
