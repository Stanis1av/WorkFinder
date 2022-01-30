Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    get 'home/index'
    root 'home#index'

    devise_for :users, skip: :omniauth_callbacks

    resource :job_seeker, path: 'jobseeker_profile', only: %i[ show edit update ]
    resource :company, path: 'company_profile', only: %i[ show edit update ]
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}
end
