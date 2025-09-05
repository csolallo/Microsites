require 'rspec'
require_relative '../bin/sources/core'
require_relative '../bin/sources/king_county_water_taxi/vashon_parser'

describe Sources::KingCountyWaterTaxi::VashonParser do
  it 'should report format error if weekday table is not found' do
    contents = File.read('./samples/v_unexpected_table.html')
    expect { subject.parse(contents) }.to raise_error(Sources::FormatChanged)
  end
end
