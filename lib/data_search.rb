# frozen_string_literal: true

require 'data_search/version'
require 'data_search/constants'
require 'data_search/input_arg_parser'
require 'data_search/data_repository'
require 'data_search/command_line'

##
# The root-level module encapsulating classes and modules that make up the "DataSearch" app
# This defines the entry point (#start method)

module DataSearch
  ##
  # The entry-point to the app. Called from bin/data_search
  #
  # ==== Examples
  #
  # require 'data_search'
  #
  # DataSearch.start
  #
  def self.start
    file_paths = InputArgParser.new.parse(ARGV)
    data = DataRepository.new(file_paths).data

    CommandLine.new(data: data).run
  end
end
