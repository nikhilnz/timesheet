require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require_relative 'timesheet'

require 'mongo'
require_relative '../db/personal_holiday'

configure do
  MongoMapper.setup({'production' => {'uri' => 'mongodb:/pub_hols'}}, 'production')
end


get '/timesheet/dates' do
  slim :'dates'
end

get '/timesheet/generate' do
  @month = params['month']
  @year = params['year'].to_i
  timesheet = Timesheet.new().generate(@month, @year)
  slim :'timesheet', locals: {timesheet: timesheet}
end

post '/timesheet/submit' do

end
