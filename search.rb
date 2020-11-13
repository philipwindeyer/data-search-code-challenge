#!/usr/bin/env ruby

require 'optparse'

args = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: ./search.rb [options]'
  
  opts.on("-t", "--term search-term", "Term for search with (optional)") do |value|
    args[:term] = value
  end
end.parse!

welcome_message = <<~WELCOME
  Welcome to Zendesk Search
  Type 'quit' to exit at any time, Press 'Enter' to continue
  
WELCOME

puts welcome_message

puts "Search term: #{args[:term]}" if args[:term]
