require 'date'
require 'json'
require 'rake'
require 'yaml'
require_relative 'bin/schedule_builder'
require_relative 'bin/utils'

# We'll exploit Jekyll's ability to handle blog posts. 
# 
# Each "post" will contain the departure times from the post title to the destination
# in the front matter.
# 
# The schedule for that day will be represented as a markdown table
namespace 'posts' do
  task :generate => [:clear] do |t, args|
    urls = get_source_page_urls
    ws_timetable = build_schedule Sources::WEST_SEATTLE
    vashon_timetable = build_schedule Sources::VASHON

    today = Date.today
    (today-6..today).each do |day|
      create_ws_post day, urls[:west_seattle], ws_timetable
      create_vashon_post day, urls[:vashon], vashon_timetable
      create_seattle_post day, urls[:seattle], ws_timetable, vashon_timetable
    end
  end
  
  task :clear do |t, args|
    Dir.foreach('_posts') { |file| File.delete("_posts/#{file}") unless File.directory? "_posts/#{file}" }
  end
end

def create_ws_post(day, source_url, timetable)
  file_name = day.strftime('%Y-%m-%d-west-seattle.md')
  File.open("./_posts/#{file_name}", 'w') do |f|
    f.print "---\n"
    f.print "layout: taxi_schedule\n"
    f.print "destination: Seattle\n"
    f.print "page_source: #{source_url}\n"
    f.print "---\n"
    f.print "\n"
    f.print "**{{ page.title | propercase }}** ➡ ⛴️ ➡ **{{page.destination}}**\n"
    f.print "\n"
    f.print "|#{'Departs'.ljust(8)}|\n"
    f.print "|#{'-' * 8}|\n"
    
    key = day.strftime('%a').to_schedule_key
    timetable[key][:west_seattle].each do |time|
      f.print "|#{time.ljust(8)}|\n"
    end
    f.print "\n"
    f.print "Generated: {{ site.time | date: \"%m/%d/%Y @ %H:%M:%S\" }}\n"
  end
end

def create_vashon_post(day, source_url, timetable)
  file_name = day.strftime('%Y-%m-%d-vashon.md')
  File.open("./_posts/#{file_name}", 'w') do |f|
    f.print "---\n"
    f.print "layout: taxi_schedule\n"
    f.print "destination: Seattle\n"
    f.print "page_source: #{source_url}\n"
    f.print "---\n"
    f.print "\n"
    f.print "**{{ page.title | propercase }}** ➡ ⛴️ ➡ **{{page.destination}}**\n"
    f.print "\n"
    f.print "|#{'Departs'.ljust(8)}|\n"
    f.print "|#{'-' * 8}|\n"

    key = day.strftime('%a').to_schedule_key
    has_times = false
    timetable[key][:vashon].each do |time|
      has_times = true
      f.print "|#{time.ljust(8)}|\n"
    end
    f.print "||\n" unless has_times
    f.print "\n"
    f.print "Generated: {{ site.time | date: \"%m/%d/%Y @ %H:%M:%S\" }}\n"
  end  
end

def create_seattle_post(day, source_url, ws_timetable, vashon_timetable)
  file_name = day.strftime('%Y-%m-%d-seattle.md')
  File.open("./_posts/#{file_name}", 'w') do |f|
    f.print "---\n"
    f.print "layout: taxi_schedule\n"
    f.print "page_source: #{source_url}\n"
    f.print "---\n"
    f.print "\n"
    f.print "**{{ page.title | propercase }}** ➡ ⛴️ ➡ **West Seattle**\n"
    f.print "\n"
    f.print "|#{'Departs'.ljust(8)}|\n"
    f.print "|#{'-' * 8}|\n"
    
    key = day.strftime('%a').to_schedule_key

    ws_timetable[key][:seattle].each do |time|
      f.print "|#{time.ljust(8)}|\n"
    end

    f.print "\n"
    f.print "**{{ page.title | propercase }}** &#27A1 ⛴️ ➡ **Vashon**\n"
    f.print "\n"
    f.print "|#{'Departs'.ljust(8)}|\n"
    f.print "|#{'-' * 8}|\n"

    has_times = false
    vashon_timetable[key][:seattle].each do |time|
      has_times = true
      f.print "|#{time.ljust(8)}|\n"
    end
    f.print "||\n" unless has_times
    f.print "\n"
    f.print "Generated: {{ site.time | date: \"%m/%d/%Y @ %H:%M:%S\" }}\n"
  end
end  
