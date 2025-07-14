if Rails.env.development?
  Rails.application.routes.default_url_options[:host]     = 'localhost:3000'
  Rails.application.routes.default_url_options[:protocol] = 'http'
elsif Rails.env.production?
  # Configure seu host de produção aqui
  Rails.application.routes.default_url_options[:host]     = 'www.solary.com.br'
  Rails.application.routes.default_url_options[:protocol] = 'https'
end

# Herda a configuração para o Action Mailer
ActionMailer::Base.default_url_options = Rails.application.routes.default_url_options
