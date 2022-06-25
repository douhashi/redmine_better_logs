Redmine::Plugin.register :redmine_better_logs do
  name 'Redmine Better Logs plugin'
  author 'Sho DOUHASHI'
  description 'This is a better log features for Redmine 4.x or higher'
  version '0.0.1'
  url 'https://github.com/douhashi/redmine_better_logs'
  author_url 'https://github.com/douhashi'

  settings default: { enabled: true }, partial: 'redmine_better_logs/settings/redmine_better_logs_settings'
end

if Setting.plugin_redmine_better_logs['enabled']
  Rails.application.configure do
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new

    config.lograge.custom_payload do |controller|
      params = controller.request.params.except(* %w[controller action])
      {
        request_id: controller.request.request_id,
        current_user: "#{User.current&.login.present? ? User.current&.login : 'anonymous'}",
        current_user_id: "#{User.current&.id}",
        params: params
      }
    end

    config.lograge.custom_options = lambda do |event|
      data = {
        level: 'INFO',
        type: 'access',
      }
      data
    end
  end
end

