
begin
  require 'rspec/core/rake_task'

  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end

  RSpec::Core::RakeTask.new(:spec)

  task :default => [:spec, :features]
rescue LoadError
  # no rspec available
end