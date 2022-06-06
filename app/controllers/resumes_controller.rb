class ResumesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :is_not_jobseeker?, except: :index
  before_action :set_resume, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    # @resumes = Resume.all
    @resumes = resumes
    @query = query
  end

  def new
    current_job_seeker
    @resume = Resume.new
    # @resume.work_experiences.build
    # @resume.educations.build
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

  def destroy
    if @resume.destroy
      redirect_to resumes_path, notice: "Успешно удалено!"
    else
      render action: 'show', alert: "Не удалось удалить объект"
    end
  end

  private

  def current_job_seeker
    @job_seeker = current_user.job_seeker
  end

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def is_the_owner
    current_user.job_seeker.id == Resume.find(params[:id]).job_seeker_id
  end

  def is_not_jobseeker?
    if current_user.role != 'job_seeker'
      redirect_to root_path, alert: "Вы не соискатель, доступ запрещен"
    end
  end

  def resumes
    if query
      Resume.where("headline ILIKE ?", "%#{query}%")

      # Resume.joins(:skills).where("name ILIKE ?", "%#{query}%")
    else
      Resume.all
    end
  end

  def query
    params[:query]
  end

  def resume_params
    params.require(:resume).permit( :avatar,
                                    :first_name,
                                    :last_name,
                                    :age,
                                    :headline,
                                    :email,
                                    :phone_number,
                                    :country_of_residence,
                                    :city_or_state_of_residence,
                                    :relocation,
                                    :remote,
                                    :skill_list,
                                    work_experiences_attributes: [
                                      :id,
                                      :job_title,
                                      :description,
                                      :company,
                                      :country_of_work,
                                      :city_or_state_of_work,
                                      :i_currently_work_here,
                                      :from,
                                      :to,
                                      :_destroy],
                                    educations_attributes: [
                                      :id,
                                      :level_of_education,
                                      :field_of_study,
                                      :school_name,
                                      :country,
                                      :city_or_state,
                                      :currently_enrolled,
                                      :from,
                                      :to,
                                      :_destroy])
  end
end
