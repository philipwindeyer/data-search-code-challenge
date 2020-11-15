# frozen_string_literal: true

# require 'active_support/core_ext/string/inflections'

module DataSearch
  module Searchable
    def valid_search_field?(field)
      searchable.include?(field.to_sym)
    end

    def search(field, term)
      data.select do |object|
        object_value = object[field.to_sym]

        if object_value.respond_to?(:each)
          object_value.map { |value| value.to_s.casecmp?(term) }.any?
        else
          object_value.to_s.casecmp?(term)
        end
      end
    end
  end
end
