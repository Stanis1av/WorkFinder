Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    get 'home/index'
    root 'home#index'

    devise_for :users, skip: :omniauth_callbacks

  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}
end
