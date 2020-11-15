# frozen_string_literal: true

module DataSearch
  module CommandLineSearchMethods
    def search
      collection = select_data_collection

      field = select("Select search term:", collection.searchable)
      term = ask('Enter search value:')

      puts "Searching #{collection.name.downcase} for #{field} with a value of #{term}\n"
      results = collection.search(field, term)
      print_formatted_results(results)
    end

    def print_searchable_fields
      data.each do |collection|
        puts "\n--------------------"
        puts "Search #{collection.name} with"

        collection.searchable.each do |searchable|
          puts searchable
        end
      end
    end

    private

    def select_data_collection
      options = data.map.with_index { |option, index| { name: option.name, value: index } }
      selection = select("Select:", options)

      data[selection]
    end

    def print_formatted_results(results)
      puts 'No results found' if results.empty?

      results.each do |result|
        puts "\n--------------------"

        result.each do |key, value|
          puts "#{key.to_s.ljust(32)}#{value}"
        end
      end
    end
  end
end
