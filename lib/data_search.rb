#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'readline'
require 'data_search/searchable_fields'
require 'data_search/version'

module DataSearch
  class Error < StandardError; end

  args = {}

  OptionParser.new do |opts|
    opts.banner = 'Usage: ./search.rb [options]'

    opts.on('-t', '--term search-term', 'Term for search with (optional)') do |value|
      args[:term] = value
    end
  end.parse!

  welcome_message = <<~WELCOME
    Welcome to Zendesk Search
    Type 'quit' to exit at any time, Press 'Enter' to continue
  WELCOME

  puts welcome_message

  puts "Search term: #{args[:term]}" if args[:term]

  exit if gets.chomp == 'quit'

  # SearchableFields.new('TODO')

  instruction_message = <<-INSTRUCTION
    Select search options:
    * Press 1 to search Zendesk
    * Press 2 to view a list of searchable fields
    * Type 'quit'

  INSTRUCTION

  puts instruction_message

  while true
    input = gets.chomp
    
    if input == 'quit'
      puts 'kthxbai'
      exit
    end
  end
end
