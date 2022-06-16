Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    root to: "homepage#index"

    devise_for :users, controllers: {
        registrations: 'users/registrations'
      }

    resource :job_seeker, path: 'jobseeker_profile', only: [:edit, :update, :show]
    resource :employer, path: 'employer_profile', only: [:edit, :update, :show]

    resources :resumes
    # FORM WIZARD
      # resources :steps, only: [:show, :update, :create], controller: 'steps_controllers/resume_steps'

    resources :vacancies
    resources :build_vacancy, only: [:update, :show], controller: 'steps_controllers/vacancy_steps'

    get '/resumes/skill/:id', to: 'resume_skills#show', as: 'resumes_skill'
    get '/vacancies/skill/:id', to: 'vacancy_skills#show', as: 'vacancies_skill'

    resource :about, only: :show

  end
end
