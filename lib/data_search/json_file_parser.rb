# frozen_string_literal: true

require 'json'

module DataSearch
  # Parses JSON files using the built-in Ruby JSON parser.
  class JsonFileParser
    # Parses the file provided, returning an array of hashes representing the data provided in the file00
    #
    # @param file_path [String] path to file to be parsed
    #
    # @return [Hash || Hash[]] array/hash of object(s) in file provided

    # @raise [ArgumentError] if file_path is nil
    # @raise [TypeError] if file_path is not a string
    # @raise [JSON::ParserError] if data in file is not parseable
    #
    # @example Ask parser to pass cmd args using ARGV
    #   data = JsonFileParser.read_data_from_file('organisations.json')
    def self.read_data_from_file(file_path)
      new.read_data_from_file(file_path)
    end

    def read_data_from_file(file_path)
      raise ArgumentError, 'invalid argument' if file_path.nil?

      file_string = read_file(file_path)
      parse(file_string)
    end

    private
    def read_file(file_path)
      File.open(file_path).read
    end

    def parse(file_string)
      JSON.parse(file_string, symbolize_names: true)
    end
  end
end
