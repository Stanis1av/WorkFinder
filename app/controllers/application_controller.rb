class ApplicationController < ActionController::Base
  before_action :set_locale_from_subdomain

  private

  def set_locale_from_subdomain
    # detecting the current locale (request = http://localhost:3000/)
    detected_locale = request.host.split('.').first
    # Find and use an available locale. Otherwise, the default locale is used.
    I18n.locale = I18n.available_locales.map(&:to_s).include?(detected_locale) ? detected_locale : I18n.default_locale

    # Debug logger
    logger.debug "detected_locale = #{request.host.split('.').first.inspect}"
    logger.debug "available_locales.include = #{I18n.available_locales.map(&:to_s).include?(detected_locale)}"
    logger.debug "available_locales = #{I18n.available_locales.map(&:to_s).inspect}"
  end

end
