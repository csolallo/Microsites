
# frozen_string_literal: true

require 'rspec'
require_relative '../bin/sources/king_county_water_taxi/main'

describe Sources::KingCountyWaterTaxi::Parser do
  before(:context) do 
    @contents = File.read('./samples/taxi-schedule.html')
  end

  it 'should correctly parse schedule from West Seattle' do
    subject.parse @conents do |timetable|
      puts timetable
    end
  end

  xit 'should correctly parse schedule from downtown Seattle' do
    
  end

  xit 'should correctly parse schedule from Vashon' do
    
  end
end
