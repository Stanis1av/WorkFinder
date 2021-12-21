class ResumesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :is_not_jobseeker?, except: :index
  before_action :set_resume, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @resumes = Resume.all
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.create(resume_params)
    @resume.job_seeker_id = current_user.job_seeker.id

    if @resume.valid?
      @resume.save
      redirect_to resume_path(id: @resume.id), notice: "Резюмe успешно создано"
    else
      render action: "new", alert: "Создание резюме не удалось"
    end
  end

  def edit
    if !is_the_owner
      render @resume
    end
  end

  def update
    if @resume.update(resume_params)
      redirect_to resume_path(id: @resume.id), notice: "Резюмe успешно обновлено"
    else
      render action: "index", alert: "Обновление не удалось"
    end
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def is_the_owner
    current_user.job_seeker.id == Resume.find(params[:id]).job_seeker_id
  end

  def is_not_jobseeker?
    if current_user.role != 'jobseeker'
      redirect_to root_path, alert: "Вы не соискатель, доступ запрещен"
    end
  end

  def resume_params
    params.require(:resume).permit( :first_name,
                                    :last_name,
                                    :phone_number,
                                    :country,
                                    :street_address,
                                    :city_or_state,
                                    :skill_list)
  end
end
