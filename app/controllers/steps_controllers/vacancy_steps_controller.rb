module StepsControllers
  class VacancyStepsController < ApplicationController
    include Wicked::Wizard

    steps *Vacancy.form_steps.keys

    def show
      vacancy_attrs = Rails.cache.fetch "#{session.id}_vacancy"
      @employer = current_user.employer
      @vacancy = Vacancy.new vacancy_attrs
      render_wizard
    end

    def update
      vacancy_attrs = Rails.cache.fetch("#{session.id}_vacancy").merge vacancy_params
      @vacancy = Vacancy.new vacancy_attrs
      @vacancy.employer_id = current_user.employer.id

      if @vacancy.valid?
        Rails.cache.write "#{session.id}_vacancy", vacancy_attrs
        redirect_to_next next_step
      else
        render_wizard nil, status: :unprocessable_entity
      end
    end

    private

    def vacancy_params
      params.require(:vacancy).permit(Vacancy.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      vacancy_attrs = Rails.cache.fetch("#{session.id}_vacancy")
      @vacancy = Vacancy.new vacancy_attrs
      @vacancy.employer_id = current_user.employer.id

      @vacancy.save!
      Rails.cache.delete "#{session.id}_vacancy"
      vacancy_path(I18n.locale, @vacancy)
    end
  end
end
