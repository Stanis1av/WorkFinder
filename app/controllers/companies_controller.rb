class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :show]
  # before_action :authenticate_user!

  def show
    if current_user.company != nil
      # render the show screen
      render action: 'show'
    else
      redirect_to root_path, alert: 'Доступ запрещён'
    end
  end

  def edit
    if current_user.company != nil
      # render the show screen
      render action: 'edit'
    else
      redirect_to root_path, alert: 'Доступ запрещён'
    end
  end

  def update
    if @company.valid?
      @company.update(company_params)
      redirect_to company_path, notice: 'Профиль успешно обновлён'
    else
      render action: 'edit', alert: 'Не удалось обновить профиль'
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit( :name,
                                     :about,
                                     :website,
                                     :email )
  end
end
