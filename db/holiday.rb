require 'mongo_mapper'
class Holiday
  include MongoMapper::Document

  key :name,    String
  key :date, Time
  key :no_of_days, Integer
  key :day, String
end