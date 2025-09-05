require 'nokogiri'
require_relative 'base_parser'

module Sources
  module KingCountyWaterTaxi
    
    class VashonParser < BaseParser
      PAGE_URI = 'https://kingcounty.gov/en/dept/metro/travel-options/water-taxi/vashon#toc-sailing-schedule'
      
      def parse(contents)
        result = {
          :seattle => [],
          :vashon => []
        }

        doc = Nokogiri::HTML4(contents)
        schedule_container = doc.css('div[id=schedule-table-weekday]')
        if schedule_container.nil?
          raise Sources::FormatChanged.new "weekday table not found"
        end

        seattle_departures, vashon_departures = *parse_schedule(schedule_container, 'Departs Pier 50', 'Departs Vashon')
        result[:seattle] = seattle_departures
        result[:valshon] = vashon_departures

        if block_given? 
          yield result
        else 
          return result
        end
      end
    end

  end
end