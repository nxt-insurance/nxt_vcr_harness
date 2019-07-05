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

NxtVcrHarness currently has two features. You can use it to find vcr cassettes that are not being used when you 
run your test suite. Enable it by calling `NxtVcrHarness.track_cassettes_if(...your condition in here...)`. 
Note that the output only makes sense when you run your complete test suite. 
If you run only a subset all cassettes that are used by your other test will be included too.

The second feature is that you can enable your custom :vcr tag by calling `NxtVcrHarness.enable_vcr_tag`. This will 
automatically name your vcr cassettes based on the your rspec example and the surrounding contexts. You can also 
setup default cassette options for your vcr tag. 

```ruby
NxtVcrHarness.enable_vcr_tag(tag_name: :my_vcr_tag, default_cassette_options: { ... })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nxt-insurance/nxt_vcr_harness.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
