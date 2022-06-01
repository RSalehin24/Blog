class MyMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    opts[:from] = 'blogs4248@gmail.com'
    opts[:reply_to] = 'blogs4248@gmail.com'
    super
  end

  def reset_password_instructions(record, token, opts={})
    opts[:from] = 'blogs4248@gmail.com'
    opts[:reply_to] = 'blogs4248@gmail.com'
    super
  end

end