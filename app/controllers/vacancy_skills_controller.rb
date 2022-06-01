class VacancySkillsController < ApplicationController
  def show
    @skill = Skill.friendly.find(params[:id])
  end
end
