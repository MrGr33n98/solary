Rails.application.routes.default_url_options[:host] = ENV.fetch("HOST", "localhost:3000")
Rails.application.routes.default_url_options[:protocol] = ENV.fetch("PROTOCOL", "http")

# Herda a configuração para o Action Mailer
ActionMailer::Base.default_url_options = Rails.application.routes.default_url_options