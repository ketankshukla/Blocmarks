ActionMailer::Base.smtp_settings = {
    port:              587,
    address:           'smtp.mailgun.org',
    user_name:         ENV['MAILGUN_SMTP_LOGIN'],
    password:          ENV['MAILGUN_SMTP_PASSWORD'],
    domain:            'https://api.mailgun.net/v3/appf4864058f4844855936af56a1beaa328.mailgun.org',
    authentication:    :plain,
    content_type:      'text/html'
}
ActionMailer::Base.delivery_method = :smtp

# Makes debugging *way* easier.
ActionMailer::Base.raise_delivery_errors = true

