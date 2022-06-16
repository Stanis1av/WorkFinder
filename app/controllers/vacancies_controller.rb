class VacanciesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :is_not_employer?, except: [:index, :show]
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    # @vacancies = Vacancy.all
    @vacancies = vacancies
    @query = query
  end

  def new
    current_employer
    @vacancy = Vacancy.new

    Rails.cache.fetch("#{session.id}_vacancy") { Hash.new }  # Only non-vanilla-Rails code here
    # debugger
    redirect_to build_vacancy_path(@vacancy, Vacancy.form_steps.keys.first) # Only non-vanilla-Rails code here
  end

  def create

    @vacancy = Vacancy.new(vacancy_params)
    @vacancy.employer_id = current_user.employer.id

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to vacancy_path(@vacancy.id), notice: "Резюмe успешно создано." }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    if !is_the_owner
      render @vacancy
    end
  end

  def update
    if @vacancy.update(vacancy_params)
      redirect_to vacancy_path(id: @vacancy.id), notice: "Вакансия успешно обновлено"
    else
      render action: "edit", alert: "Обновление не удалось"
    end

  end

  # DELETE /houses/1 or /houses/1.json
  def destroy
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to vacancies_url, notice: "House was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def current_employer
    @employer = current_user.employer
  end

  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def is_the_owner
    current_user.employer.id == Vacancy.find(params[:id]).employer_id
  end

  def is_not_employer?
    if current_user.role != 'employer'
      redirect_to root_path, alert: "Вы не работодатель, доступ запрещен"
    end
  end

  def vacancies
    if query
      Vacancy.where("job_title ILIKE ?", "%#{query}%")
    else
      Vacancy.all
    end
  end

  def query
    params[:query]
  end

  def vacancy_params
    params.require(:vacancy).permit(:job_title,
                                    :company_name,
                                    :country,
                                    :city_or_state,

                                    :work_experience,
                                    :job_type,
                                    :schedule_job,

                                    :from,
                                    :to,
                                    :currency,
                                    :rate,

                                    :description,

                                    :first_name,
                                    :last_name,
                                    :phone,
                                    :email,

                                    :skill_list)

  end
end
