# frozen_string_literal: true

module DataSearch
  module Searchable

    def search(field, term)
      [].tap do |results|
        data.map do |object|
          match = has_matching_nested_value?(field, term, object) || matches?(field, term, object)
          
          if match
            results << object unless results.include?(object)
          end
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

    def has_matching_nested_value?(field, term, object)
      return false unless field.include?('.')

      nested_field = field.split('.').last.to_sym
      
      deeply_nested = object.deep_locate ->(key, value, _object) do
        key == nested_field && value.to_s.casecmp?(term)
      end

      deeply_nested.any?
    end

    def matches?(field, term, object)
      return false if field.include?('.')

      object_value = object[field.to_sym]
      
      if object_value.respond_to?(:each)
        object_value.map { |value| value.to_s.casecmp?(term) }.any?
      else
        object_value.to_s.casecmp?(term)
      end
    end

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
