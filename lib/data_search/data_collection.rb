# frozen_string_literal: true

module DataSearch
  class DataCollection
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
