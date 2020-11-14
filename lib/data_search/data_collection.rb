# frozen_string_literal: true

module DataSearch
  class DataCollection
    attr_reader :name, :data

    def initialize(name, data)
      @name = name
      @data = data
    end

    # TODO make this not shit... it's awfully implemented atm
    # maybe gradually build up an array, checking if arg already exists before adding

    def searchable
      if data.is_a?(Array)
        data.map do |object|
          get_keys(object)
        end.flatten.uniq
      else
        get_keys(data).flatten.uniq
      end
    end

    private

    def get_keys(object)
      object.map do |key, value|
        if value.respond_to?(:keys)
          [key] | get_keys(value)
        else
          key
        end
      end
    end
  end
end
