Bundler.require :test

require_relative '../lib/timesheet_routes'

describe 'Timesheet Api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context '/holidays/add' do
    it 'adds personal holidays to the db' do
      # :from => '01/01/2013', :to => '09/01/2013', :type => 'vacation'
      person_holiday = double('person_holiday')
      expect(PersonalHoliday).to receive(:new).with(:from => '1/12/2013', :to => '31/12/2013', :type => 'vacation').and_return(person_holiday)
      expect(person_holiday).to receive(:save!)
      post('/holidays/add', from_day: '1', to_day: '31', month: '12', year: '2013')
    end
  end
end
