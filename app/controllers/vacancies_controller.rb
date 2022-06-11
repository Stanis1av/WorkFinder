class VacanciesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :is_not_employer?, except: :index
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
  end

  def create
    @vacancy = Vacancy.create(vacancy_params)
    @vacancy.employer_id = current_user.employer.id
    # debugger
    if @vacancy.valid?
      @vacancy.save
      redirect_to vacancy_path(id: @vacancy.id), notice: "Резюмe успешно создано"
    else
      render action: "new", alert: "Создание вакансии не удалось"
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
                                    :logo,
                                    :company_name,
                                    :location,
                                    :country,
                                    :remote,
                                    :type_of_job,
                                    :salary,
                                    :description,
                                    :skill_list)
  end
end
