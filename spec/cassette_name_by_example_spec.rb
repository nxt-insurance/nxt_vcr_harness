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
      it 'names the file appropriately', :vcr_cassette do |example|
        expect(
          described_class.new(example).call
        ).to match(
          /\A\/cassette_name_by_example_spec\/NxtVcrHarness::CassetteNameByExample\/call\/with_an_it_block\/names_the_file_appropriately\z/
        )
      end
    end
  end
end