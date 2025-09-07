require 'date'
require 'json'
require 'rake'
require 'yaml'
require_relative 'bin/schedule_builder'
require_relative 'bin/utils'

# we'll exploit Jekyll's ability to handle blog posts. We'll create a blog post a sailing
# the title for the post will be the starting port
# the desitnation port will be a category
# the schedule for that day will be represented as a markdown table
namespace 'posts' do
  task :generate do |t, args|
    urls = get_source_page_urls
  
    #seattle_ws_times = []

    build_schedule Sources::WEST_SEATTLE do |timetable|
      today = Date.today
      (today-6..today).each do |day|
        file_name = day.strftime('%Y-%m-%d-west-seattle.md')
        File.open("./_posts/#{file_name}", 'w') do |f|
          f.print "---\n"
          f.print "layout: taxi_schedule\n"
          f.print "destination: Seattle\n"
          f.print "page_source: #{urls[:west_seattle]}\n"
          f.print "---\n"
          f.print "\n"
          f.print "**{{ page.title | propercase }}** to **{{page.destination}}**\n"
          f.print "\n"
          f.print "|#{'Departs'.ljust(8)}|\n"
          f.print "|#{'-' * 8}|\n"

          key = day.strftime('%a').to_schedule_key
          timetable[key][:west_seattle].each do |time|
            f.print "|#{time.ljust(8)}|\n"
          end
        end
      end
    end

    build_schedule Sources::VASHON do |timetable|
      today = Date.today
      (today-6..today).each do |day|
        file_name = day.strftime('%Y-%m-%d-vashon.md')
        File.open("./_posts/#{file_name}", 'w') do |f|
          f.print "---\n"
          f.print "layout: taxi_schedule\n"
          f.print "destination: Seattle\n"
          f.print "page_source: #{urls[:vashon]}\n"
          f.print "---\n"
          f.print "\n"
          f.print "**{{ page.title | propercase }}** to **{{page.destination}}**\n"
          f.print "\n"
          f.print "|#{'Departs'.ljust(8)}|\n"
          f.print "|#{'-' * 8}|\n"

          key = day.strftime('%a').to_schedule_key
          has_times = false
          timetable[key][:vashon].each do |time|
            has_times = true
            f.print "|#{time.ljust(8)}|\n"
          end
          f.print '||' unless has_times
        end
      end
    end    
  end
  
  task :clear do |t, args|
    Dir.foreach('_posts') { |file| File.delete("_posts/#{file}") unless File.directory? "_posts/#{file}" }
  end
end
