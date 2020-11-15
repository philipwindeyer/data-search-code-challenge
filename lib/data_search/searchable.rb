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
