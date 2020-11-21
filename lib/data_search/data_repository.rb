# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'data_search/json_file_parser'
require 'data_search/data_collection'

module DataSearch
  # "Repository" that, via JSON files provided, builds @see DataCollection objects per file
  class DataRepository
    DEFAULTS = [
      'organizations.json',
      'tickets.json',
      'users.json'
    ].freeze

    attr_reader :file_paths

    # @param file_paths [String[]] file path list. Default == []
    #
    # @raise [ArgumentError] if file_paths is not an array
    def initialize(file_paths = [])
      raise ArgumentError, 'invalid argument' unless file_paths.is_a?(Array)

      @file_paths = file_paths.any? ? file_paths : DEFAULTS
    end

    # Builds and returns a @see DataCollection object per file provided to @see DataRepository instance
    #
    # @return [DataCollection[]] array of @see DataCollection objects corresponding to each data file provided
    def data
      @data ||= begin
        file_paths.map do |file_path|
          DataCollection.new(
            get_name(file_path),
            get_data(file_path),
            get_aliases(file_path)
          )
        end
      end
    end

    private

    def get_name(file_path)
      File.basename(file_path, '.*').underscore.humanize
    end

    def get_data(file_path)
      data = JsonFileParser.read_data_from_file(file_path)
      data.is_a?(Array) ? data : [data]
    end

    def get_aliases(file_path)
      # TODO Support synonyms for related objects that refer to a collection with a different but related term
      [File.basename(file_path, '.*').underscore.downcase.singularize]
    end
  end
end
