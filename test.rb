require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'httparty'
require 'calendar_helper'


set :views, '.'
get '/name' do
  {key: 'value'}.to_json
  slim :'main'
end

post '/timesheet/submit' do

  month = Date::MONTHNAMES[Time.now.mon]
  year = Time.now.year

  pub_hols = HTTParty.get('http://localhost:4567/holidays/public').to_i
  hols_taken = HTTParty.get('http://localhost:4567/holidays/personal').to_i

  date_wrapper = CalendarHelper::DateWrapper.new(month, year)
  total_days = date_wrapper.total_days
  weekends = date_wrapper.weekends

  working_days = total_days - weekends - pub_hols - hols_taken
  "The month is #{month} and the year is #{year}. \n
Total number of days: #{total_days}. \n
The number of public holidays are #{pub_hols}. \n
The number of weekends are #{weekends}. \n
Number of holidays taken: #{hols_taken} \n
Total number of working days: #{working_days}"
end


get '/holidays' do
  {key: 'value'}.to_json
end

