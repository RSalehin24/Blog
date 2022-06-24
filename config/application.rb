require_relative "boot"

require "rails/all"
Bundler.require(*Rails.groups)

module Blogs
  class Application < Rails::Application
    config.load_defaults 7.0
    # config.after_initialize do |_config|
    #   User.update-all(status: User.statuses[:offline])
    # end

    config.active_storage.replace_on_assign_to_many = false
  end
end
