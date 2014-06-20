require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'mongo'
require_relative 'holiday'

configure do
  MongoMapper.setup({'production' => {'uri' => 'mongodb:/pub_hols'}}, 'production')
end

get '/holidays/public' do
  total_days = 0
  records = Holiday.where(:date => {:$gte => Time.parse('2014-05-1')}).where(:date => {:$lte => Time.parse('2014-05-31')})
  records.each { |r| total_days = total_days + r.no_of_days.to_i }
  "#{total_days}"
end

get '/holidays/personal' do
  "5"
end

