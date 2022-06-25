# Redmine Better Logs plugin

This plugin changes Redmine logs to JSON format.

## Plugin installation

1. Copy `redmine_better_logs` directory into the plugin directory.
2. Run install commands below:

    ```
    bundle install

    bin/rails redmine_better_logs:install RAILS_ENV=production
    ```

3. restart redmine

## Enable / Disable plugin

* Enable

    ```
    bin/rails redmine_better_logs:enable RAILS_ENV=production
    ```

    and restart redmine

* Disable

    ```
    bin/rails redmine_better_logs:disable RAILS_ENV=production
    ```

    and restart redmine

## Uninstall

1. Disable

    ```
    bin/rails redmine_better_logs:disable RAILS_ENV=production
    ```

2. Remove redmine_better_logs from plugins directory
3. Restart redmine


