require 'net/https'
require 'uri'
require_relative 'sources/core.rb'

def build_schedule(source, options={})
  ca_path = options[:ca_path] || ENV['SSL_CERT_PATH']
  ca_file = options[:ca_file] || ENV['SSL_CERT_FILE']

  case source
    when Sources::WATER_TAXI
      response = fetch_taxi_page(ca_path: ca_path, ca_file: ca_file)
      if response.is_a? Net::HTTPSuccess
        parser = Sources::KingCountyWaterTaxi::Parser.new
        timetable = parser.parse response.body
      else
        # TODO: raise an error
      end
    else
      raise Sources::UnknownSource.new "#{source} is invalid"
  end

  unless timetable.nil?
    if block_given? 
      yield timetable
    else
      return timetable
    end
  end
end

def fetch_taxi_page(**options)
  uri = URI.parse(Sources::KingCountyWaterTaxi::PAGE_URI)
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