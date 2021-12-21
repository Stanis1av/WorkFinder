class VacanciesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :is_not_company?, except: :index
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @vacancies = Vacancy.all
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.create(vacancy_params)
    @vacancy.company_id = current_user.company.id
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

  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def is_the_owner
    current_user.company.id == Vacancy.find(params[:id]).company_id
  end

  def is_not_company?
    if current_user.role != 'company'
      redirect_to root_path, alert: "Вы не компания, доступ запрещен"
    end
  end

  def vacancy_params
    params.require(:vacancy).permit( :company_name,
                                    :job_title,
                                    :location,
                                    :country,
                                    :remote,
                                    :type_of_job,
                                    :salary,
                                    :description,
                                    :skill_list)
  end
end
