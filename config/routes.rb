Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    get 'home/index'
    root 'home#index'

    devise_for :users

  end
end
