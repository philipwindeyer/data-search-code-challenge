# frozen_string_literal: true

module DataSearch
  module Searchable
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
