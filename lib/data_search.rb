# frozen_string_literal: true

require 'data_search/version'
require 'data_search/data_repository'
require 'data_search/command_line'

module DataSearch
  def self.start
    data = DataSearch::DataRepository.new.data
    CommandLine.new(data: data).run
  end
end
