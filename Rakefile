require 'rake'
require_relative 'bin/schedule_builder'

namespace 'generate' do
  task :water_taxi_schedule do |t, args|
    build_schedule Sources::WATER_TAXI do |timetable|
      puts timetable
    end
  end  
end
