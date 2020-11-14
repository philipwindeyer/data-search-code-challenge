# frozen_string_literal: true

require 'json'

module DataSearch
  class JsonFileParser
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
