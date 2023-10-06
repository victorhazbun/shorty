Rails.application.routes.draw do
  resources :url, only: :create
  resources :views, path: :v, only: :show
end
