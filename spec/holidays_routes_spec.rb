Bundler.require :test

require_relative '../lib/holidays_routes'

describe 'Holidays Api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context '/holidays/public' do
    it 'retrieves the total number of holidays for a given month' do
      response = get('/holidays/public', from: '2014-05-01', to: '2014-05-31')
      expect(response.body).to eq(2.to_s)
    end
  end

end