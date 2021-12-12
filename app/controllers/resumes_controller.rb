class ResumesController < ApplicationController
  # before_action :authenticate_user!, except: :index
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
      logger.debug "#{'=' * 70}"
      logger.debug "@resume.save #{@resume.save}"
      logger.debug "#{'=' * 70}"
      logger.debug "@resume \n#{@resume}"
      logger.debug "#{'=' * 70}"
      @resume.save
      redirect_to resume_path(id: @resume.id), notice: "Резюмe успешно создано"
    else
      logger.debug "#{'=' * 70}"
      logger.debug "@resume.save #{@resume.save}"
      logger.debug "#{'=' * 70}"
      logger.debug "@resume \n#{@resume}"
      logger.debug "#{'=' * 70}"
      logger.debug "#{}"
      logger.debug "#{'=' * 70}"
      render action: "new", alert: "Создание резюме не удалось"
    end
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
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
