module ApplicationHelper
  def embedded_svg(icon_name, options={})
    file = File.read(Rails.root.join('app', 'assets', 'images', 'navbar', "#{icon_name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each {|attr, value| svg[attr.to_s] = value}

    doc.to_html.html_safe
  end

  def user_avatar(user, size = 40)
    user.avatar.variant(resize: "#{size}x#{size}!")
  end

  def company_logo (company, size = 40)
    company.logo.variant(resize: "#{size}x#{size}!")
  end

  def is_job_seeker?
    current_user.present? && current_user.role == 'job_seeker'
  end
  def is_company?
    current_user.present? && current_user.role == 'company'
  end
end
