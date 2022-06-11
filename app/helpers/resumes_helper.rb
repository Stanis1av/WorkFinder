module ResumesHelper
  def is_relocation(result)
    result == true ? t('.willing_relocate') : t('.not_willing_relocate') ;
  end

  def is_remote(result)
    result == true ? t('.willing_remote') : t('.not_willing_remote') ;
  end

  # "#{I18n.l(experience.from, format: "%B")}, #{experience.to.year}" %> - <%= "#{I18n.l(experience.to, format: "%B")}, #{experience.from.year}"
  def readable_month_and_year_experience(experience)
    if experience.from.present? && experience.from.year.present? && experience.to.present? && experience.to.year.present?
      month_from = I18n.l(experience.from, format: "%B")
      year_from = experience.from.year

      month_to = I18n.l(experience.to, format: "%B")
      year_to = experience.to.year

      return "#{month_from}, #{year_from} - #{month_to}, #{year_to}"
    elsif experience.from.present? && experience.from.year.present? || experience.i_currently_work_here == true && experience.from.present?
      month_from = I18n.l(experience.from, format: "%B")
      year_from = experience.from.year

      return "#{month_from}, #{year_from} - По настоящее время"
    else
      return "не указано"
    end
  end

  def readable_month_and_year_education(education)
    if education.from.present? && education.from.year.present? && education.to.present? && education.to.year.present?
      year_from = education.from.year

      year_to = education.to.year

      return "#{year_from} - #{year_to}"
    elsif education.from.present? && education.from.year.present? || currently_enrolled == true && education.from.present?
      year_from = education.from.year

      return "#{year_from} - По настоящее время"
    else
      return "не указано"
    end
  end


  def resume_skill_list
    @resume.skills.collect do |skill|
            skill.name
        end.join(", ")
  end
end
