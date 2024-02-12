
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nxt_vcr_harness/version"

Gem::Specification.new do |spec|
  spec.name          = "nxt_vcr_harness"
  spec.version       = NxtVcrHarness::VERSION
  spec.authors       = ["Andreas Robecke", "Nils Sommer", "Raphael Kallensee"]
  spec.email         = ["a.robecke@getsafe.de"]

  spec.summary       = %q{Intuitive VCR cassette naming}
  spec.description   = %q{Names your vcr cassettes based on your rspec examples and let's you pass in options on the fly}
  spec.homepage      = "https://github.com/nxt-insurance"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/nxt-insurance/nxt_vcr_harness"
    spec.metadata["changelog_uri"] = "https://github.com/nxt-insurance/nxt_vcr_harness/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "vcr", "~> 6.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec_junit_formatter"
end
