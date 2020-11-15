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

    def searchable
      @searchable ||= begin
        [].tap do |fields|
          data.map do |object|
            get_keys(object, fields)
          end
        end
      end
    end

    private

    def get_keys(object, fields)
      object.map do |key, value|
        fields << key unless fields.include?(key)
        get_keys(value, fields) if value.respond_to?(:keys)
      end
    end
  end
end
