class EmployersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employer, only: [:edit, :update, :show]
  # before_action :authenticate_user!

  def show
    if current_user.employer != nil
      # render the show screen
      render action: 'show'
    else
      redirect_to root_path, alert: 'Доступ запрещён'
    end
  end

  def edit
    if current_user.employer != nil
      # render the show screen
      render action: 'edit'
    else
      redirect_to root_path, alert: 'Доступ запрещён'
    end
  end

  def update
    if @employer.valid?
      @employer.update(employer_params)
      redirect_to employer_path, notice: 'Профиль успешно обновлён'
    else
      render action: 'edit', alert: 'Не удалось обновить профиль'
    end
  end

  private

  def set_employer
    @employer = current_user.employer
  end

  def employer_params
    params.require(:employer).permit(:logo,
                                     :name,
                                     :about_employer,
                                     :website,
                                     :email )
  end
end
