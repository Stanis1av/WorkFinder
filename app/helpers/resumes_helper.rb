module ResumesHelper
  def is_relocation(result)
    result == true ? t('.willing_relocate') : t('.not_willing_relocate') ;
  end

  def is_remote(result)
    result == true ? t('.willing_remote') : t('.not_willing_remote') ;
  end

  def resume_skill_list
    @resume.skills.collect do |skill|
            skill.name
        end.join(", ")
  end
end
