# frozen_string_literal: true

require 'data_search/searchable'

module DataSearch
  # A PORO to store data that makes up a "data collection"
  #   Stores the "name" of the collection, and the "data" itself (as an array of hashes)
  #   It is extended by the @see Searchable module to provide search methods
  class DataCollection
    include Searchable
    attr_reader :name, :data, :aliases

    def initialize(name, data, aliases = [])
      @name = name
      @data = data
      @aliases = aliases
    end
  end
end
