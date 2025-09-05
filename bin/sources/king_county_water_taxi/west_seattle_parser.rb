require 'nokogiri'
require_relative 'base_parser'

module Sources
  module KingCountyWaterTaxi
    
    class WestSeattleParser < BaseParser
      PAGE_URI = 'https://kingcounty.gov/en/dept/metro/travel-options/water-taxi/west-seattle#toc-sailing-schedule'
      
      def parse(contents)
        result = {
          :m2t => {
            :seattle => [],
            :west_seattle => []
          },
          :fri => {
            :seattle => [],
            :west_seattle => []
          },
          :sat => {
            :seattle => [],
            :west_seattle => []
          },
          :sun => {
            :seattle => [],
            :west_seattle => []
          }
        }

        on_key_match = Proc.new { |key, old_value, new_value| old_value + new_value }

        doc = Nokogiri::HTML4(contents)

        schedule_containers = doc.css('div[id^=schedule-table]')
        schedule_containers.each do |container|
          seattle_departures, west_seattle_departures = *parse_schedule(container, 'Departs Pier 50', 'Departs West Seattle')
          temp = {
            :seattle => seattle_departures,
            :west_seattle => west_seattle_departures
          }
          if container.values[0] == 'schedule-table-mon-to-thurs'
            result[:m2t].merge!(temp, &on_key_match)
          elsif container.values[0] == 'schedule-table-fri'
            result[:fri].merge!(temp, &on_key_match)
          elsif container.values[0] == 'schedule-table-sat'
            result[:sat].merge!(temp, &on_key_match)
          elsif container.values[0] == 'schedule-table-sun'
            result[:sun].merge!(temp, &on_key_match)
          else
            raise Sources::FormatChanged.new "unexpected container #{container.values[0]}"
          end
        end
        if block_given? 
          yield result
        else 
          return result
        end
      end     
    end

  end
end
