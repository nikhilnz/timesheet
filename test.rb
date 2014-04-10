require 'json'
require 'sinatra'
require 'slim'

set :views, '.'
get '/name' do
  {key: 'value'}.to_json
  slim :'main'
end

post '/name' do
  ""
end

