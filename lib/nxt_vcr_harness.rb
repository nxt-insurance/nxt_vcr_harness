require "nxt_vcr_harness/version"
require 'nxt_vcr_harness/cassette_name_by_example'
require 'nxt_vcr_harness/cassette_tracker'

module NxtVcrHarness
  module VcrCassetteHelper
    def with_vcr_cassette(example, **options, &block)
      cassette_by_example_options = %i[prefix suffix]
      cassette_path = CassetteNameByExample.new(example).call(options.slice(*cassette_by_example_options))

      vcr_options = options.reject { |k,_| k.in?(cassette_by_example_options) }

      ::VCR.use_cassette(cassette_path, **vcr_options) do
        block.call
      end
    end

    def hash_from_example(example, **options)
      cassette_by_example_options = %i[prefix suffix]
      name = CassetteNameByExample.new(example).call(options.slice(*cassette_by_example_options))
      Digest::MD5.hexdigest(name)
    end
  end

  def enable_vcr_tag(options = {})
    tag_name = options.fetch(:tag_name, :vcr_cassette)
    default_cassette_options = options.fetch(:default_cassette_options, {})

    RSpec.configure do |config|
      config.around(:each, tag_name) do |example|
        cassette_path = CassetteNameByExample.new(example).call(options.slice(:prefix, :suffix))
        cassette_options = example.metadata[tag_name].is_a?(TrueClass) ? {} : example.metadata[tag_name]
        cassette_options = default_cassette_options.merge(cassette_options)

        VCR.use_cassette(cassette_path, **cassette_options) do
          example.call
        end
      end
    end
  end

  def enable_vcr_cassette_helper
    RSpec.configure do |config|
      config.include VcrCassetteHelper
    end
  end

  def track_cassettes
    RSpec.configure do |config|
      config.after(:suite) do
        CassetteTracker.instance.stats
        CassetteTracker.instance.reveal_unused_cassettes(::VCR.configuration.cassette_library_dir)
      end
    end

    VCR.configure do |config|
      config.before_playback do |_, cassette|
        CassetteTracker.instance.track(cassette)
      end
    end
  end

  module_function :enable_vcr_tag, :track_cassettes, :enable_vcr_cassette_helper
end
