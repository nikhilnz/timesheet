Then(/^I should see '(.*)'$/) do |text|
  expect(page).to have_text(text)
end

And(/^I view the timesheet for the month '(.*)' and year '(.*)'$/) do |month, year|
  visit("/timesheet/#{year}/#{month}")
end