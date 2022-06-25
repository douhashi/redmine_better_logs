require_relative './redmine_log_formatter'

Rails.application.configure do
  logger = ActiveSupport::Logger.new(config.paths['log'].first)
  logger.formatter = RedmineBetterLogs::RedmineLogFormatter.new
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.new(logger)
end
