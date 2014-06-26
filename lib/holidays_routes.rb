require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'mongo'
require_relative '../db/holiday'

configure do
  MongoMapper.setup({'production' => {'uri' => 'mongodb:/pub_hols'}}, 'production')
end

get '/holidays/public/view' do

end

get '/holidays/public' do
  from = Time.parse(params[:from])
  to = Time.parse(params[:to])
  puts from
  puts to
  records = Holiday.where(:date => {:$gte => from}).where(:date => {:$lte => to})
  total_days = records.inject(0) {|result, record| result + record.no_of_days.to_i}
  "#{total_days}"
end

get '/holidays/personal' do
  "7"
end

