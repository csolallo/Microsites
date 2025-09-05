# frozen_string_literal: true

require 'rspec'
require_relative '../bin/sources/core'
require_relative '../bin/sources/king_county_water_taxi/west_seattle_parser'

describe Sources::KingCountyWaterTaxi::WestSeattleParser do
  context "mon-thurs schedule" do
    it 'should report format error if table columns changed' do
      contents = File.read('./samples/ws_m2t_changed_th.html')
      expect { subject.parse(contents) }.to raise_error(Sources::FormatChanged)
    end
  end

  context 'friday schedule' do
    it 'should report format error on unexpected table id' do
      contents = File.read('./samples/ws_new_table_fri-sat_id.html')
      expect { subject.parse(contents) }.to raise_error(Sources::FormatChanged)
    end
  end    
end
