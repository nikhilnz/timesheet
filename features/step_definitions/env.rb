require 'selenium-webdriver'
require 'capybara/cucumber'
require 'mongo'
require_relative '../../db/timesheet_db'

MongoMapper.setup({'development' => {'uri' => 'mongodb:/timesheet_test'}}, 'development')

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:3000'

