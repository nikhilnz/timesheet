require 'date'
month = Time.now.mon
month_str = Date::MONTHNAMES[month]
year = Time.now.year

first_day_of_month = Date.new(year, month, 1)
last_day_of_month = Date.new(year, month+1, 1) - 1

puts "The month is #{month_str} and the year is #{year}"
puts "There are #{(last_day_of_month).day} days in this month"

count = 0
(first_day_of_month.day.to_i .. last_day_of_month.day.to_i).each do |day|
  count +=  1 if Date.new(year, month, day).saturday? || Date.new(year, month, day).sunday?
end

puts "#{count} weekends"

HttpParty.get('www.google.co.uk')