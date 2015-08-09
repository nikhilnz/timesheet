And(/^I choose the month '(.*)' and year '(.*)'$/) do |month, year|
  select(month, :from => 'month')
  select(year, :from => 'year')
end

When(/^I click '(.*)'$/) do |button|
  click_on(button)
end

Given(/^I have a timesheet submitted for the month '(.*)' and year '(.*)' with days worked '(.*)'$/) do |month, year, days_worked|
  timesheet_db = TimesheetDb.new(:days_worked => days_worked.to_i, :month => month, :year => year)
  timesheet_db.save!
end