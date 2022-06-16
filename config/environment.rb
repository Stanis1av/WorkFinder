# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

host = 'workfinder.site'
#config.action_mailer.default_url_options = { :host => host }

if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = host
end
