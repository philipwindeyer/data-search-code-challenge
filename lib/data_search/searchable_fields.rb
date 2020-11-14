module DataSearch
  class SearchableFields

    attr_reader :files

    def initialize(files)
      @files = files
    end

    def searchable_fields
      files.map do |file|
        # TODO implement me
      end
    end

    private

    def searchable_fields_by_file
    end
  end
end
