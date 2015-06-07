And(/^I choose the month '(.*)' and year '(.*)'$/) do |month, year|
  select(month, :from => 'month')
  select(year, :from => 'year')
end

When(/^I click '(.*)'$/) do |button|
  click_on(button)
end