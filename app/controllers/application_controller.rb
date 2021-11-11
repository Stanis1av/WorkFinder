class ApplicationController < ActionController::Base
  before_action :set_locale_from_subdomain

  private

  def set_locale_from_subdomain
    # detecting the current locale (request = http://localhost:3000/)
    detected_locale = request.host.split('.').first

    # Find and use an available locale. Otherwise, the default locale is used.
    I18n.locale = I18n.available_locales.map(&:to_s).include?(detected_locale) ? detected_locale : browser_locale

    # Debug logger
    # logger.debug "browser_locale: #{browser_locale}"
    logger.debug "current host: #{request.host.inspect}"
    logger.debug "first host element: #{request.host.split('.').first.inspect}"
    logger.debug "available locales = #{I18n.available_locales.map(&:to_s).inspect}"
    logger.debug "I18n.locale = #{I18n.locale}"
  end

  def browser_locale

    locales = request.env['HTTP_ACCEPT_LANGUAGE'] || ""

    # Debug logger
    # logger.debug "HTTP_ACCEPT_LANGUAGE = #{request.env['HTTP_ACCEPT_LANGUAGE'].inspect}"
    # logger.debug "scan #{locales.scan(/[a-z]{2}/).inspect}" # scan(/[a-z]{2}(?=;)/)
    # logger.debug "locales.empty? = #{locales.empty?}"

    if locales.empty?
      return I18n.default_locale
    end

    locales.scan(/[a-z]{2}/).find do |locale|
      return locale if I18n.available_locales.include?(locale.to_sym)
    end
  end

end
