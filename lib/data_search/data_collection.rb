# frozen_string_literal: true

module DataSearch
  class DataCollection
    attr_reader :name, :data

    def initialize(name, data)
      @name = name
      @data = data
    end
  end
end
