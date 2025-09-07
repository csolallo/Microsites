require 'net/https'
require 'uri'
require_relative 'sources/core.rb'
require_relative 'sources/king_county_water_taxi/west_seattle_parser'
require_relative 'sources/king_county_water_taxi/vashon_parser'

def build_schedule(source, options={})
  case source
    when Sources::WEST_SEATTLE
      uri = URI.parse(Sources::KingCountyWaterTaxi::WestSeattleParser::PAGE_URI)
      parser = Sources::KingCountyWaterTaxi::WestSeattleParser.new
    when Sources::VASHON
      uri = URI.parse(Sources::KingCountyWaterTaxi::VashonParser::PAGE_URI)
      parser = Sources::KingCountyWaterTaxi::VashonParser.new
    else
      raise Sources::UnknownSource "#{source} is unknown" 
  end

  ca_path = options[:ca_path] || ENV['SSL_CERT_PATH']
  ca_file = options[:ca_file] || ENV['SSL_CERT_FILE']
  
  response = fetch_taxi_page(uri, ca_path: ca_path, ca_file: ca_file)
  if response.is_a? Net::HTTPSuccess
    timetable = parser.parse response.body
  else
    raise Sources::NetworkError.new "#{response}"
  end

  unless timetable.nil?
    if block_given? 
      yield timetable
    else
      return timetable
    end
  end
end

def get_source_page_urls
  {
    :west_seattle => Sources::KingCountyWaterTaxi::WestSeattleParser::PAGE_URI,
    :vashon => Sources::KingCountyWaterTaxi::VashonParser::PAGE_URI,
    :seattle => 'https://kingcounty.gov/en/dept/metro/travel-options/water-taxi'
  }  
end

def fetch_taxi_page(uri, **options)
  Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
    http.ca_path = options[:ca_path]
    http.ca_file = options[:ca_file]

    # page will return content in deflate or gzip by default. 
    headers = {
      'accept' => 'text/html',
      'accept-encoding' => 'utf-8'
    }

    http.get(uri.path, headers)
  end
end