Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    devise_for :users
    root to: "homepage#index"

    resource :job_seeker, path: 'jobseeker_profile', only: [:edit, :update, :show]
    resource :company, path: 'company_profile', only: [:edit, :update, :show]

    resource :about, only: :show

  end
end
