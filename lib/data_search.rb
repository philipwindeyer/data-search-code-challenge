# frozen_string_literal: true

require 'data_search/version'
require 'data_search/data_repository'
require 'data_search/command_line'

module DataSearch
  def self.start
    data = DataSearch::DataRepository.new.data

    command_line = CommandLine.new(data: data)
    command_line.run
  end
end
