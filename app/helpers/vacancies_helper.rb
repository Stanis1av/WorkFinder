module VacanciesHelper
  def currency(currency)
    case currency

    when 'rub'
      t('.rub')
    when 'usd'
      t('.usd')
    when 'eur'
      t('.eur')
    else
      t('.rub')
    end
  end

  def rate(rate)
    case rate

    when 'hour'
      t('.hour')
    when 'day'
      t('.day')
    when 'week'
      t('.week')
    when 'month'
      t('.month')
    when 'year'
      t('.year')
    else
      t('.month')
    end
  end

  def work_experience(work_experience)
    case work_experience

    when 'not_required'
      t('.not_required')
    when 'f1_t3'
      t('.f1_t3')
    when 'f3_t6'
      t('.f3_t6')
    when 'more_6'
      t('.more_6')
    else
      t('.not_required')
    end
  end

  def job_type(job_type)
    case job_type

    when 'full_time'
      t('.full_time')
    when 'part_time'
      t('.part_time')
    when 'temporary'
      t('.temporary')
    when 'contract'
      t('.contract')
    when 'internship'
      t('.internship')
    when 'commission'
      t('.commission')
    else
      t('.undefined')
    end
  end

  def schedule_job(schedule_job)
    case schedule_job

    when 'hour_8'
      t('.hour_8')
    when 'hour_10'
      t('.hour_10')
    when 'hour_12'
      t('.hour_12')
    when 'on_call'
      t('.on_call')
    else
      t('.other')
    end

  end

  def vacancy_skill_list
    @vacancy.skills.collect do |skill|
            skill.name
        end.join(", ")
  end
end
