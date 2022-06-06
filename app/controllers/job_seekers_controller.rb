class JobSeekersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_seeker, only: [:edit, :update, :show]

  def show
    if current_user.job_seeker != nil
      # render the show screen
      render action: 'show'
    else
      redirect_to root_path, alert: 'Доступ запрещён'
    end
  end

  def edit
    if current_user.job_seeker != nil
      # render the show screen
      render action: 'edit'
    else
      redirect_to root_path, alert: 'Доступ запрещён'
    end
  end

  def update
    # debugger
    if @job_seeker.valid?
      @job_seeker.update(job_seeker_params)
      redirect_to job_seeker_path, notice: 'Профиль успешно обновлён'
    else
      render action: 'edit', alert: 'Не удалось обновить профиль'
    end
  end

  private

  def set_job_seeker
    @job_seeker = current_user.job_seeker
  end

  def job_seeker_params
    params.require(:job_seeker).permit(:avatar,
                                       :first_name,
                                       :last_name,
                                       :age,
                                       :email,
                                       :phone_number,
                                       location_attributes: [
                                         :id,
                                         :country_of_residence,
                                         :city_or_state_of_residence,
                                         :street_address_residence,
                                         :relocation])
  end
end
