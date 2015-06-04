require 'httparty'
require 'calendar_helper'

class Timesheet

  attr_reader :working_days, :weekends, :total_days, :pub_hols , :hols_taken

  def generate(month, year)
    date_wrapper = CalendarHelper::DateWrapper.new(month, year)

    @from = "#{year}-#{month}-1"
    @to = "#{year}-#{month}-#{date_wrapper.total_days}"

    @pub_hols = HTTParty.get('http://localhost:4567/holidays/public', :query => {:from => @from, :to => @to}).to_i
    @hols_taken = HTTParty.get('http://localhost:4567/holidays/personal').to_i

    @total_days = date_wrapper.total_days
    @weekends = date_wrapper.weekends

    @working_days = @total_days - @weekends - @pub_hols - @hols_taken
    self
  end
end