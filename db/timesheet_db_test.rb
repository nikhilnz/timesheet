require 'mongo'
require 'time'
require 'bson/bson_ruby'
require_relative 'timesheet_db'

mongo_client = Mongo::MongoClient.new("localhost", 27017)
MongoMapper.setup({'production' => {'uri' => 'mongodb:/timesheet_test'}}, 'production')
# puts mongo_client.database_names
# puts mongo_client.database_info.each { |info| puts info.inspect }

db2 = mongo_client.db("timesheet_test")
coll = db2.collection("timesheet_dbs")
# coll.find.each { |row| puts row.inspect }

 puts TimesheetDb.first.month

# coll.remove
# timesheet_db = TimesheetDb.new(:days_worked => 3, :month => 'Test', :year => 'Tst')
# timesheet_db.save!

# s = "557750bfc720b227dc000001"
# puts coll.find("_id" => BSON::ObjectId(s)).first

# coll.find.each do |c|
#    puts coll.find("_id" => BSON::ObjectId(c.id)).to_a
#
# end