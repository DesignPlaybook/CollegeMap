# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# config/schedule.rb


set :output, {
    error: "#{ENV["APP_PATH"]}/log/cron_error.log",
    standard: "#{ENV["APP_PATH"]}/log/cron.log"
}

set :environment, "production"  # or "development" for local testing

every 1.day, at: '2:00 am' do
  rake "cleanup:old_csvs"
end
