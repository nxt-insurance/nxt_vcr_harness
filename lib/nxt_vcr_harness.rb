require "nxt_vcr_harness/version"
require 'nxt_vcr_harness/cassette_name_by_example'

module NxtVcrHarness
  def configure(tag_name = :vcr_cassette)
    RSpec.configure do |config|
      config.around(:each, tag_name) do |example|
        cassette_path = CassetteNameByExample.new(example).call
        vcr_options = example.metadata[tag_name].is_a?(TrueClass) ? { } : example.metadata[tag_name]

        VCR.use_cassette(cassette_path, **vcr_options) do
          example.call
        end
      end
    end
  end

  module_function :configure
end
