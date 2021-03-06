# frozen_string_literal: true

require 'hashie/extensions/deep_locate'

module DataSearch
  # A module providing search related methods on objects that store an array known as "data" (e.g. @see DataCollection)
  module Searchable
    # Searches data using the "field" to base the search on, and a "term" (or string) to value-match on
    #   If a top-level "field" is provided, a "breadth-first" search is conducted, iterating over the object in "data" to find matches.
    #   If a "nested" field is provided, a "depth-first" search is conducted with the help of @see Hashie::Extensions::DeepLocate.
    #
    #   When a nested search is conducted, objects in the available data are extended by Hashie::Extensions::DeepLocate iteratively as needed rather than at the top-level to avoid unnecesarily extending objects unless required.
    #
    # @param field [String] the object field/key
    #
    # @param term [String] the value to search with
    #
    # @return [Hash[]] array of objects that match the search criteria
    #
    # @example
    #   data = DataCollection.new('Collection', [...])
    #   search_results = data.search('id', '2')
    def search(field, term)
      data.select do |object|
        if nested_search?(field)
          matching_nested_value?(field, term, object)
        else
          matches?(field, term, object)
        end
      end
    end

    # Returns an array of "searchable fields" i.e. keys of an object that can be used to search with
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

    def nested_search?(field)
      field.include?('.')
    end

    def supports_dfs?(object)
      object.respond_to?(:deep_locate)
    end

    def matching_nested_value?(field, term, object)
      nested_field = field.split('.').last.to_sym
      object.extend(Hashie::Extensions::DeepLocate) unless supports_dfs?(object)

      deeply_nested = object.deep_locate ->(key, value, _object) do
        key == nested_field && value.to_s.casecmp?(term)
      end

      deeply_nested.any?
    end

    def matches?(field, term, object)
      object_value = object[field.to_sym]

      if object_value.nil?
        false
      elsif object_value.respond_to?(:each)
        object_value.map { |value| value.to_s.casecmp?(term) }.any?
      elsif term.blank?
        object_value.blank?
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
