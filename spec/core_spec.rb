require 'date'
require_relative '../bin/utils'

describe 'added string methods' do
  it 'a day string should return a valid schedule key' do
    today = Date.today
    (today..today+6).each do |day|
        short_day = day.strftime('%a')
        expect(short_day.to_schedule_key).to_not be_nil
    end    
  end
end