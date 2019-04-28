module NxtVcrHarness
  class CassetteNameByExample
    def initialize(example)
      @example = example
    end

    attr_reader :example

    def call
      cassette_name_and_path
    end

    def cassette_name_and_path
      spec_path = example.file_path.gsub(/\.rb$/, '').gsub('./spec/', '/')
      [spec_path, cassette_name_from_descriptions].join('/')
    end

    def cassette_name_from_descriptions
      descriptions = context_hierarchy_with_vcr_cassette_tags.map { |c| c[:description] }
      descriptions.map(&method(:gsub_whitespace)).map(&method(:remove_hash_tags))
    end

    def gsub_whitespace(name)
      name.gsub(/\s+/, '_')
    end

    def remove_hash_tags(name)
      name.delete('#')
    end

    def context_hierarchy_with_vcr_cassette_tags
      @context_hierarchy_with_vcr_cassette_tags ||= begin
        context_hierarchy.reverse.inject([]) do |acc, context|
          acc << context
          break acc if context[:vcr_cassette]

          acc
        end
      end
    end

    def context_hierarchy
      @context_hierarchy ||= begin
        context_hierarchy = [example.metadata]
        example_group = example.metadata[:example_group]
        context_hierarchy << example_group

        while parent_example_group = example_group[:parent_example_group] do
          context_hierarchy << parent_example_group
          example_group = parent_example_group
        end

        context_hierarchy
      rescue StandardError => e
        raise StandardError, "Failed to build context hierarchy for example: #{example} - Error was: #{e.inspect}"
      end
    end
  end
end