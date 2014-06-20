require 'mongo_mapper'

MongoMapper.setup({'production' => {'uri' => 'mongodb:/pub_hols'}}, 'production')

class Holiday
  include MongoMapper::Document

  key :name,    String
  key :date, Time
  key :no_of_days, Integer
  key :day, String
end


# require 'json'
#
# h = JSON.parse File.read('holiday_format.json')
#
# puts h['holidays'].count
#
# h['holidays'].each do |holiday|
#   Holiday.create holiday
# end

total_days = 0
records = Holiday.where(:date => {:$gte => Time.parse('2014-04-1')}).where(:date => {:$lte => Time.parse('2014-04-30')})
records.each do |r|
  total_days = total_days + r.no_of_days.to_i
end

puts 'done'
puts total_days