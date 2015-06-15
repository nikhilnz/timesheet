Bundler.require :test

require 'mongo'
require_relative '../db/personal_holiday'
require_relative '../lib/holidays_routes'

describe 'Holidays Api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context '/holidays/public' do
    it 'retrieves the total number of holidays for a given month' do
      response = get('/holidays/public', month: 'May', year: 2014)
      expect(response.body).to eq(2.to_s)
    end
  end


  context '/holidays/personal' do
    context '/post' do
      it 'adds personal holidays to the db' do

        PersonalHoliday.delete_all

        params = {
            from_day: '1', from_month: '12', from_year: '2013',
            to_day: '1', to_month: '12', to_year: '2014'
        }
        post('/holidays/personal', params)


        expect(PersonalHoliday.size).to eq(1)
        expect(PersonalHoliday.first.type).to eq('vacation')
        expect(PersonalHoliday.first.from).to eq('2013-12-01 00:00:00 UTC')
        expect(PersonalHoliday.first.to).to eq('2014-12-01 00:00:00 UTC')
      end
    end

    context '/get' do
      it 'retrieves personal holidays from the db' do
        PersonalHoliday.delete_all
        person_holiday = PersonalHoliday.new(:from => '1/1/2013', :to => '5/1/2013', :type => 'vacation')
        person_holiday.save!

        response = get('/holidays/personal', {month: 'January', year: 2013})
        expect(JSON.parse(response.body).symbolize_keys!).to eq({from: '2013-01-01T00:00:00.000Z', to: '2013-01-05T00:00:00.000Z', type: 'vacation', duration: 5})
      end
    end
  end
end