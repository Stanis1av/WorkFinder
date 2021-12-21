Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    root to: "homepage#index"

    devise_for :users, controllers: {
        registrations: 'users/registrations'
      }

    resource :job_seeker, path: 'jobseeker_profile', only: [:edit, :update, :show]
    resource :company, path: 'company_profile', only: [:edit, :update, :show]

    resources :resumes
    resources :vacancies

    resources :skills

    resource :about, only: :show

  end
end
