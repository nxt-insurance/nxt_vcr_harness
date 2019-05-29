RSpec.describe NxtVcrHarness::CassetteNameByExample do
  describe '#call' do
    context 'when there is a context', :vcr_cassette do
      it 'names the file appropriately' do |example|
        expect(
          described_class.new(example).call
        ).to match(
          /\A\/cassette_name_by_example_spec\/NxtVcrHarness::CassetteNameByExample\/call\/when_there_is_a_context\z/
        )
      end
    end

    context 'with an it block' do
      it 'names the file appropriately', :with_vcr_cassette do |example|
        expect(
          described_class.new(example).call
        ).to match(
          /\A\/cassette_name_by_example_spec\/NxtVcrHarness::CassetteNameByExample\/call\/with_an_it_block\/names_the_file_appropriately\z/
        )
      end
    end

    context 'with prefix' do
      it 'prefixes the path', :with_vcr_cassette do |example|
        expect(
          described_class.new(example).call(prefix: 'features')
        ).to match(
          /\A\/features\/cassette_name_by_example_spec\/NxtVcrHarness::CassetteNameByExample\/call\/with_prefix\/prefixes_the_path\z/
        )
      end
    end

    context 'with suffix' do
      it 'adds a suffix to the path', :with_vcr_cassette do |example|
        expect(
          described_class.new(example).call(suffix: 'setup')
        ).to match(
          /\A\/cassette_name_by_example_spec\/NxtVcrHarness::CassetteNameByExample\/call\/with_suffix\/adds_a_suffix_to_the_path\/setup\z/
        )
      end
    end
  end
end