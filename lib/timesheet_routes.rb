require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'httparty'
require 'calendar_helper'


get '/name' do
  {key: 'value'}.to_json
  slim :'main'
end

get '/timesheet/dates' do
  slim :'dates'
end

get '/timesheet/generate' do
  @month = params['month']
  @year = params['year'].to_i
  generate_timesheet(@month, @year)
  slim :'timesheet'
end

get '/holidays/add' do
  slim :'add_holidays'
end

post '/timesheet/submit' do

end

def generate_timesheet(month, year)
  date_wrapper = CalendarHelper::DateWrapper.new(month, year)

  @from = "#{year}-#{month}-#{date_wrapper.first_day_of_month}"
  @to = "#{year}-#{month}-#{date_wrapper.last_day_of_month}"

  @pub_hols = HTTParty.get('http://localhost:4567/holidays/public', :query => {:from => @from, :to => @to}).to_i
  @hols_taken = HTTParty.get('http://localhost:4567/holidays/personal').to_i

  @total_days = date_wrapper.total_days
  @weekends = date_wrapper.weekends

  @working_days = @total_days - @weekends - @pub_hols - @hols_taken
end


