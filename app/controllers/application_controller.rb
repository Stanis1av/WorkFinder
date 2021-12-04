class ApplicationController < ActionController::Base
  before_action :set_locale_from_subdomain

  private

  def set_locale_from_subdomain
    # detected_locale = request.host.split('.').first # set locale via subdomen
    detected_locale = request.fullpath.split('/').second # set locale via path

    # Find and use an available locale. Otherwise, the default locale is used.
    I18n.locale = I18n.available_locales.map(&:to_s).include?(detected_locale) ? detected_locale : browser_locale

  end

  def browser_locale

    locales = request.env['HTTP_ACCEPT_LANGUAGE'] || ""

    if locales.empty?
      return I18n.default_locale
    end

    locales.scan(/[a-z]{2}/).find do |locale|
      return locale if I18n.available_locales.include?(locale.to_sym)
    end
  end

end
