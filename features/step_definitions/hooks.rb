Before do
  TimesheetDb.delete_all
  Holiday.delete_all
  holiday = Holiday.new(:name => 'August bank holiday', :date => Time.parse('2015-08-30'), :no_of_days => 1, :day => '')
  holiday.save!
end
