require 'mongo'
require 'time'
mongo_client = Mongo::MongoClient.new("localhost", 27017)

# puts mongo_client.database_names # lists all database names

# puts mongo_client.database_info.each { |info| puts info.inspect }

# db = mongo_client.db("mydb")
# coll = db.collection("testData")
# coll.find.each { |row| puts row.inspect }

puts "*************************"
#
# puts coll.find.to_a
#
# puts coll.count


db2 = mongo_client.db("pub_hols")
coll = db2.collection("testData")
coll.find.each { |row| puts row.inspect }
# puts 'dddd'
# date_new = Time.parse("2014-12-24")
# puts coll.find("date" => {$lte => date_new}).to_a
coll.remove
=begin
(1..8).each do |i|
  s = "53728352c720b21fcc00000#{i}"
  puts coll.find("_id" => BSON::ObjectId(s)).to_a
  puts "."
  coll.remove("_id" => BSON::ObjectId(s)).to_a
end
=end

# puts coll.find("_id" => "53728352c720b21fcc000001").to_a


=begin

require 'json'

h = JSON.parse File.read('holiday_format.json')

puts h['holidays'].count

h['holidays'].each do |holiday|
  coll.insert holiday
end
=end
