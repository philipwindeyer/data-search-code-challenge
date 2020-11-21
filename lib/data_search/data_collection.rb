# frozen_string_literal: true

require 'data_search/searchable'

module DataSearch

  # A PORO to store data that makes up a "data collection"
  #   Store the "name" of the collection, and the "data" itself
  #   "data" is extended @see Hashie::Extensions::DeepLocate 
  class DataCollection
    include Searchable
    attr_reader :name, :data

    def initialize(name, data)
      @name = name
      @data = data
    end
  end
end
