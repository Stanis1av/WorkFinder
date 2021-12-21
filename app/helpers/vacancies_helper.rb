module VacanciesHelper
  def vacancy_skill_list
    @vacancy.skills.collect do |skill|
            skill.name
        end.join(", ")
  end
end
