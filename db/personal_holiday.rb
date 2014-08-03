require 'mongo_mapper'
class PersonalHoliday
  include MongoMapper::Document

  key :from, Time
  key :to, Time
  key :type, String
end