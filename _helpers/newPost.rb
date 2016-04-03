# examples:
# ruby _helpers/nextMeeting.rb events
# OR
# ruby _helpers/nextMeeting.rb annoucements
# OR
# ruby _helpers/nextMeeting.rb

require 'date'


class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def light_blue
    colorize(36)
  end
end


d = DateTime.now
d.strftime("%Y-%m-%d")


category = ARGV[0]
categories = ['events', 'history', 'tutorials', 'announcements', 'volunteering']

firstRun = true


until categories.include? category do
  if firstRun && category.nil?
    puts
    puts 'What is the post\'s category? (i.e. events, volunteering, announcements, tutorials, histroy)'.green
  else
    puts 'Invalid category, try again.'.yellow
  end

  category = STDIN.gets.chop
  firstRun = false
end


puts
puts 'Who\'s the author?'.green
author = STDIN.gets.chop


puts
puts 'What\'s the meeting topic?'.green
topic = STDIN.gets.chomp
topic_slugified = topic.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')


if (category != 'events' && category != 'volunteering')
  puts
  puts 'When is the meeting? (YYYY-MM-DD)'.green
    meeting_date = STDIN.gets.chomp

  until meeting_date =~ /\d{4}\-\d{2}\-\d{2}/ do
    puts 'Invalid format, try again.'.yellow
    meeting_date = STDIN.gets.chomp
  end
end


if (category == 'events' || category == 'volunteering')
  puts
  puts 'When would you like the post to expire? (YYYY-MM-DD)'.green
  expiration_date = STDIN.gets.chomp

  until expiration_date =~ /\d{4}\-\d{2}\-\d{2}/ && expiration_date > d.strftime("%Y-%m-%d") do
    puts 'Invalid format, try again.'.yellow
    expiration_date = STDIN.gets.chomp
  end
end


path = "_posts/#{d.strftime("%Y-%m-%d")}-#{topic_slugified}.md"


File.open(path, "w") do |f|
  f.puts '---'
  f.puts 'layout: html/default'
  f.puts "title: #{topic}"
  f.puts "categories: #{category}"
  f.puts "tags: #{category}"
  f.puts "meeting_date: #{meeting_date}"
  f.puts "expiration_date: #{expiration_date}" if expiration_date
  f.puts '---'
  f.puts
  f.puts '<!-- INSERT TEXT HERE -->'
  f.puts
  f.puts "-- #{author}"
  f.puts '<!-- generated by _helpers/newPost.rb -->'
end


puts
puts 'Post ' + path.light_blue + ' successfully created'