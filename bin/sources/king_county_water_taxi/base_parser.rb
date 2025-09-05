  class BaseParser
    
    protected

    def parse_schedule(div, col_0_name, col_1_name)
      validate_columns(div, [col_0_name, col_1_name])

      col_0_departures = []
      col_1_departures = []

      departures = div.css('tbody tr')
      departures.each do |departure|
        times = departure.css('td')
        col_0_departures << times[0].text
        col_1_departures << times[1].text
      end
      [col_0_departures, col_1_departures]
    end
  
    private

    def validate_columns(container, expected_column_names)
      headers = []
      col_headers = container.css('thead tr th')
      col_headers.each { |h| headers << h.text.chomp }
    
      raise Sources::FormatChanged unless headers == expected_column_names
    end
  
  end