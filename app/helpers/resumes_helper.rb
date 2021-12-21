module ResumesHelper
  def resume_skill_list
    @resume.skills.collect do |skill|
            skill.name
        end.join(", ")
  end
end
