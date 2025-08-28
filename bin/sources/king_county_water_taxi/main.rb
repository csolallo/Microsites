module Sources
  module KingCountyWaterTaxi
    PAGE_URI = 'https://kingcounty.gov/en/dept/metro/travel-options/water-taxi/west-seattle#toc-sailing-schedule'

    class Parser
      def initialize
        #
      end

      def parse(contents)
        puts contents
        result = {}
        if block_given? 
          yield result
        else 
          return result
        end
      end 
      
      private

      # private methods
    end
  end
end
