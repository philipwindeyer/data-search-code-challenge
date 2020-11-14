# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module DataSearch
  class DataRepository
    DEFAULTS = [
      'organizations.json',
      'tickets.json',
      'users.json'
    ].freeze

    attr_reader :file_paths

    def initialize(file_paths = [])
      file_paths = [file_paths] unless file_paths.is_a?(Array) # TODO use respond_to with an array specific method (or just don't accept non-arrays)
      @file_paths = file_paths.any? ? file_paths : DEFAULTS
    end

    def data
      file_paths.map do |file_path|
        DataCollection.new(
          get_name(file_path),
          get_data(file_path)
        )
      end
    end

    private

    def get_name(file_path)
      File.basename(file_path, '.*').underscore.humanize
    end

    def get_data(file_path)
      JsonFileParser.get_object_from_file(file_path)
    end
  end
end
