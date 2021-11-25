Rails.application.routes.draw do
  devise_for :users
  root to: "homepage#index"

  resource :about, only: :show
end
