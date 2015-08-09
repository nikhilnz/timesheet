require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require_relative 'timesheet'

require 'mongo'
require_relative '../db/personal_holiday'
require_relative '../db/timesheet_db'

configure :development do
  MongoMapper.setup({'development' => {'uri' => 'mongodb:/timesheet_test'}}, 'development')
end

configure :production do
  MongoMapper.setup({'production' => {'uri' => 'mongodb:/timesheet'}}, 'production')
end


get '/timesheet/dates' do
  slim :'dates'
end

get '/timesheet/generate' do
  puts '~~~~~~~'
  puts params['month']
  puts params['year']
  puts '~~~~~~~'
  @month = params['month']
  @year = params['year'].to_i
  timesheet = Timesheet.new().generate(@month, @year)
  slim :'timesheet', locals: {timesheet: timesheet}
end

post '/timesheet/submit' do
  puts '**'
  puts params['days_worked'].to_i
  puts params['month']
  puts params['year']
  puts '**'
  timesheet_db = TimesheetDb.new(:days_worked => params['days_worked'].to_i, :month => params['month'], :year => params['year'])
  timesheet_db.save!
   redirect "/timesheet/#{params['year']}/#{params['month']}"
end

get '/timesheet/:year/:month' do
  puts params['month']
  puts params['year']
  timesheet_db = TimesheetDb.where(:month => params['month']).where(:year =>params['year']).first
  slim :saved_sheet, locals: {timesheet: timesheet_db}
end
