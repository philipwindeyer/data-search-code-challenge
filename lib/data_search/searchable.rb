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

    def get_keys(object, fields, parent = nil)
      object.map do |key, value|
        searchable_key = "#{parent.present? ? "#{parent}." : ''}#{key}"

        if value.respond_to?(:keys)
          get_keys(value, fields, searchable_key)
        else
          fields << searchable_key unless fields.include?(searchable_key)
        end
      end
    end
  end
end
