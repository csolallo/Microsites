require 'json'
require 'rake'
require_relative 'bin/schedule_builder'

namespace 'generate' do
  task :water_taxi_schedule do |t, args|
    template = JSON.load File.new('./template.json')
    build_schedule Sources::WEST_SEATTLE do |timetable|
      #update ws -> seattle times
      template["west_seattle"]["seattle"]['mon-thurs'] = timetable[:m2t][:west_seattle]
      template["west_seattle"]["seattle"]['friday'] = timetable[:fri][:west_seattle]
      template["west_seattle"]["seattle"]['saturday'] = timetable[:sat][:west_seattle]
      template["west_seattle"]["seattle"]['sunday'] = timetable[:sun][:west_seattle]

      #update seattle -> ws times
      template["seattle"]["west_seattle"]["mon-thurs"] = timetable[:m2t][:seattle]
      template["seattle"]["west_seattle"]["friday"] = timetable[:fri][:seattle]
      template["seattle"]["west_seattle"]["saturday"] = timetable[:sat][:seattle]
      template["seattle"]["west_seattle"]["sunday"] = timetable[:sun][:seattle]      
    end
    build_schedule Sources::VASHON do |timetable|
      # update vashon -> seattle times
      template["vashon"]["seattle"]["mon-thurs"] = timetable[:vashon]
      template["vashon"]["seattle"]["friday"] = timetable[:vashon]
      
      # update seattle -> vashon times
      template["seattle"]["vashon"]["mon-thurs"] = timetable[:seattle]
      template["seattle"]["vashon"]["friday"] = timetable[:seattle]
    end
    
    puts JSON.pretty_generate template
  end  
end
