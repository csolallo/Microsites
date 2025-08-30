require 'nokogiri'
require_relative 'base_parser'

require 'debug'

module Sources
  module KingCountyWaterTaxi
    PAGE_URI = 'https://kingcounty.gov/en/dept/metro/travel-options/water-taxi/west-seattle#toc-sailing-schedule'

    class WestSeattleParser < BaseParser
      def initialize
        @seattle_dartures = []
        @west_seattle_departures = []
      end

      def parse(contents)
        doc = Nokogiri::HTML4(contents)
        schedule_containers = doc.css('div[id^=schedule-table]')
        schedule_containers.each do |container|
          if container.values[0] == 'schedule-table-mon-to-thurs'
            parse_mon_to_thurs_shedule container
          else
            raise FormatChanged
          end
        end
        result = {}
        if block_given? 
          yield result
        else 
          return result
        end
      end 
      
      private

      def parse_mon_to_thurs_shedule(div)
        validate_columns(div, ['Departs Pier 50', 'Departs West Seattle'])
        # extract times
      end
    end
  end
end
