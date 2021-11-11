Rails.application.routes.draw do
  root to: "homepage#index"

  resource :about, only: :show
end
