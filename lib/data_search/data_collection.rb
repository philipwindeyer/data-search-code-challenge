# frozen_string_literal: true

require 'data_search/searchable'

module DataSearch
  class DataCollection
    include Searchable
    attr_reader :name, :data

    def initialize(name, data)
      @name = name
      @data = data
    end
  end
end
