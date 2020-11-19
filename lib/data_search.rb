# frozen_string_literal: true

require 'data_search/version'
require 'data_search/constants'
require 'data_search/input_arg_parser'
require 'data_search/data_repository'
require 'data_search/command_line'

module DataSearch
  def self.start
    file_paths = InputArgParser.new.parse(ARGV)
    data = DataRepository.new(file_paths).data

    CommandLine.new(data: data).run
  end
end
