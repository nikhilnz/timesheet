require 'slim'
require 'json'
require 'sinatra'
require 'sinatra/reloader'
require 'mongo'
require 'calendar_helper'

require_relative '../db/holiday'
require_relative '../db/personal_holiday'

configure :development do
  MongoMapper.setup({'development' => {'uri' => 'mongodb:/timesheet_test'}}, 'development')
end

configure :production do
  MongoMapper.setup({'production' => {'uri' => 'mongodb:/timesheet'}}, 'production')
end

get '/holidays/public/view' do
  slim :'public_holidays', :locals => {records: records}
end

get '/holidays/public' do
  total_days = records.inject(0) { |result, record| result + record.no_of_days.to_i }
  "#{total_days}"
end

def records
  date_wrapper = CalendarHelper::DateWrapper.new(params[:month], params[:year])
  from = Time.parse("#{params[:year]}-#{date_wrapper.month_number}-1").strftime("%Y-%m-%d")
  to = Time.parse("#{params[:year]}-#{date_wrapper.month_number}-#{date_wrapper.total_days}").strftime("%Y-%m-%d")
  Holiday.where(:date => {:$gte => from}).where(:date => {:$lte => to})
end

get '/holidays/add' do
  slim :'add_holidays'
end

post '/holidays/personal' do
  from = "#{params[:from_day]}/#{params[:from_month]}/#{params[:from_year]}"
  to = "#{params[:to_day]}/#{params[:to_month]}/#{params[:to_year]}"
  person_holiday = PersonalHoliday.new(:from => from, :to => to, :type => 'vacation')
  person_holiday.save!
end

get '/holidays/personal' do
  date_wrapper = CalendarHelper::DateWrapper.new(params[:month], params[:year])
  from = Time.parse("#{params[:year]}-#{date_wrapper.month_number}-1")
  to = Time.parse("#{params[:year]}-#{date_wrapper.month_number}-#{date_wrapper.total_days}")
  personal_holiday = PersonalHoliday.where(:from => {:$gte => from}).where(:to => {:$lte => to}).first
  {from: personal_holiday.from, to: personal_holiday.to, type: personal_holiday.type, duration: 5}.to_json
end