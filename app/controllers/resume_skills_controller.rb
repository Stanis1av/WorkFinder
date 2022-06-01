class ResumeSkillsController < ApplicationController
  def show
    @skill = Skill.friendly.find(params[:id])
  end
end
