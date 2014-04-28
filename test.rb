require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'slim'

set :views, '.'
get '/name' do
  {key: 'value'}.to_json
  slim :'main'
end

post '/timesheet/submit' do
  month = Date::MONTHNAMES[Time.now.mon]
  year = Time.now.year
  "The month is #{month} and the year is #{year}"
end

