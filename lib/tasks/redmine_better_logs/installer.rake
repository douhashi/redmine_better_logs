require 'thor'

module RedmineBetterLogs
  class Installer < Thor
    include Thor::Actions

    TEMPLATE = <<~STR
      require Rails.root.join('plugins/redmine_better_logs/lib/redmine_better_logs/setup_logger') # redmine_better_logs: Don't change this line

    STR

    no_commands do
      def install
        append_to_file(env_file, TEMPLATE)
      end

      def disable
        Setting.send("plugin_redmine_better_logs=", { 'enabled': false })
        comment_lines(env_file, /# redmine_better_logs/)
      end

      def enable
        Setting.send("plugin_redmine_better_logs=", { 'enabled': true })
        uncomment_lines(env_file, /# redmine_better_logs/)
      end

      def env_file
        Rails.root.join "config/environments/#{Rails.env}.rb"
      end
    end
  end
end

namespace :redmine_better_logs do
  desc "Install Redmine Better Logs plugin"
  task install: :environment do
    RedmineBetterLogs::Installer.new.install
  end

  desc "Disable Redmine Better Logs plugin"
  task disable: :environment do
    RedmineBetterLogs::Installer.new.disable
  end

  desc "Enable Redmine Better Logs plugin"
  task enable: :environment do
    RedmineBetterLogs::Installer.new.enable
  end
end
