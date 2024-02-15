[![CircleCI](https://circleci.com/gh/nxt-insurance/nxt_vcr_harness.svg?style=svg)](https://circleci.com/gh/nxt-insurance/nxt_vcr_harness)

# NxtVcrHarness

NxtVcrHarness helps you with vcr cassette handling in RSpec.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nxt_vcr_harness'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nxt_vcr_harness

## Usage

NxtVcrHarness provides three features.

### 1. List unused cassettes after each test run.
You can use it to find vcr cassettes that are not being used when you 
run your test suite. Enable it by calling `NxtVcrHarness.track_cassettes_if(...your condition in here...)`. 
Note that the output only makes sense when you run your complete test suite. 
If you run only a subset all cassettes that are used by your other test will be included too.

### 2. Use custom VCR tag
You can enable your custom :vcr tag by calling `NxtVcrHarness.enable_vcr_tag`. This will 
automatically name your vcr cassettes based on the your rspec example and the surrounding contexts. You can also 
setup default cassette options for your vcr tag. 

```ruby
NxtVcrHarness.enable_vcr_tag(tag_name: :my_vcr_tag, default_cassette_options: { ... })
```

### 3. Keep cassettes small by removing unneeded headers
API responses typically contain useful headers, such as information about rate limits and pagination,
but also many more unnecessary headers.
You can drastically reduce the size of your cassettes by stripping unnecessary headers before saving.

```ruby
# After VCR.configure:
NxtVcrHarness.strip_unneeded_headers_before_save
```

By default, nxt_vcr_harness will remove the following kinds of headers (case-insensitive) from responses:
- CORS headers (`Access-Control-*`)
- Headers for browsers (`X-Frame-Options`, `Content-Security-Policy`, `Strict-Transport-Security`, `X-Xss-Protection`, `Expect-Ct`...)
- Headers for browsers/proxies/CDNs (`Cache-Control`, `Etag`, `Vary`...)
- Common cloud provider headers (CloudFlare, AWS)
- Server details (`Server-Timing`, `X-Powered-By`, `X-Runtime`, `Via`, `Date`)

From requests, `Accept-Encoding` and `Expect` headers will be removed.

See `NxtVcrHarness::UnneededHeaders.default_headers_to_strip` for the full list of removed headers.

You can add or override headers to be removed (regexes or strings):

```ruby
NxtVcrHarness.strip_unneeded_headers_before_save do |headers_to_strip|
  headers_to_strip[:response] << /X-Dixa-.+/i
end
```

To run this slimming on existing cassettes, you can create a simple Ruby script or Rake task, for example::

```rb
require 'vcr'
require 'nxt_vcr_harness'

headers_to_strip = NxtVcrHarness::UnneededHeaders.default_headers_to_strip
headers_to_strip[:responses] << /X-Dixa-.+/i

task slim_cassettes: :environment do
  Dir[Rails.root.join('spec/fixtures/vcr_cassettes/**/**.yml')].each do |file_path|
    cassette = ::YAML.load(File.read(file_path))
    cassette['http_interactions'].each do |interaction|
      NxtVcrHarness::UnneededHeaders.strip(interaction['request']['headers'], headers_to_strip[:requests])
      NxtVcrHarness::UnneededHeaders.strip(interaction['response']['headers'], headers_to_strip[:responses])
    end
    File.write(file_path, VCR.cassette_serializers[:yaml].serialize(cassette))
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nxt-insurance/nxt_vcr_harness.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
