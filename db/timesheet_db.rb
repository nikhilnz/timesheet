require 'mongo_mapper'
class TimesheetDb
  include MongoMapper::Document
  key :days_worked, Integer
  key :month, String
  key :year, String
end

# :working_days, :weekends, :total_days, :pub_hols , :hols_taken