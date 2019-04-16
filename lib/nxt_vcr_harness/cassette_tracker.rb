require 'singleton'

class CassetteTracker
  include Singleton

  def initialize
    @cassettes = []
  end

  def stats
    puts '.'
    puts "Stubbed #{playback_count} HTTP requests using #{cassette_file_names_from_used_cassettes.count} cassettes"
  end

  def reveal_unused_cassettes(library_dir)
    all_cassette_paths = Dir.glob("#{library_dir}/**/*.yml")
    unused_cassettes = (all_cassette_paths - cassette_file_names_from_used_cassettes)
    if unused_cassettes.any?
      puts "The following cassettes are unused: "
      puts unused_cassettes.join(' ')
    else
      puts "There are no unused cassettes"
    end
  end

  def cassette_file_names_from_used_cassettes
    cassettes.map(&:file).uniq
  end

  def playback_count
    cassettes.count
  end

  def track(cassette)
    cassettes << cassette
  end

  attr_accessor :cassettes
end
