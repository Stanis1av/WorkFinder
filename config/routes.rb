Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    # devise_for :users
    devise_for :users, controllers: {
        registrations: 'users/registrations'
      }

    # devise_for :users, controllers: { sessions: 'users/registrations' }
    root to: "homepage#index"

    resource :job_seeker, path: 'jobseeker_profile', only: [:edit, :update, :show]
    resource :company, path: 'company_profile', only: [:edit, :update, :show]

    resources :resumes
    resources :skills
    resource :about, only: :show

  end
end
