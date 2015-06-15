Bundler.require :test

require_relative '../lib/timesheet'
require 'webmock/rspec'

describe Timesheet do

  context '.generate' do

    before do
      stub_request(:get, 'http://localhost:4567/holidays/public')
      .with(:query => {from: "2014-January-1", to: "2014-January-31"})
      .to_return(body: "2")

      stub_request(:get, 'http://localhost:4567/holidays/personal')
      .to_return(body: "3")

      subject.generate('January', 2014)
    end

    its(:weekends) { should eq(8) }
    its(:total_days) { should eq(31) }
    its(:pub_hols) { should eq(2) }
    its(:hols_taken) { should eq(3) }
    its(:working_days) { should eq(18) }
  end
end