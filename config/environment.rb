# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delievery_method= :smtp
ActionMailer::Base.perform_delieveries = true
ActionMailer::Base.smtp_settings = {
  addess: 'smtp.gmail.com',
  port: 465,
  domain: 'gmail.com',
  user_name: 'reyanussalehin@iut-dhaka.edu',
  password: 'r1124.S@96#',
  authentication: 'plain',
  :ssl => true,
  :tsl => true,
  enable_starttls_auto: true
}