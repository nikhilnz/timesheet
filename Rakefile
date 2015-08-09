
begin
  require 'rspec/core/rake_task'

  require 'cucumber'
  require 'cucumber/rake/task'
  require 'childprocess'
  # require 'waitforit'
  require 'selenium/webdriver/common/wait'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end

  RSpec::Core::RakeTask.new(:spec)

  task :start_up do
    puts "IN TASK"
    # process = ChildProcess.build("cmd.exe", "/c", "echo 'Hello World'")
    process = ChildProcess.build("ruby", "lib/timesheet_routes.rb", "-p 3000")
    # puts process.windows?
    process.detach = true
    process.io.inherit!
    process.start

    # Selenium::WebDriver::Wait.new.until do
    #   !port_available?(3000)
    # end

    sleep 15
    puts 'started'


    # ruby 'lib/holiday_routes.rb'
  end

  task :default => [:spec, :features]
rescue LoadError
  # no rspec available
end

def port_available? port
  case RbConfig::CONFIG["arch"]
    when /darwin/
      `netstat -an | grep #{port} | grep LISTEN`.empty?
    else
      `fuser -n tcp #{port}`.empty?
  end
end