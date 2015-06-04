require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'

require 'mongo'
require_relative '../db/personal_holiday'

configure do
  MongoMapper.setup({'production' => {'uri' => 'mongodb:/pub_hols'}}, 'production')
end


get '/timesheet/dates' do
  slim :'dates'
end

post '/timesheet/generate' do
  # @month = params['month']
  # @year = params['year'].to_i
  # generate_timesheet(@month, @year)
  # slim :'timesheet'
end

post '/timesheet/submit' do

end
