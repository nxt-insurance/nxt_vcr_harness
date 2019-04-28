RSpec.describe NxtVcrHarness::CassetteNameByExample do
  describe '#call' do
    context 'when there is a context', :vcr_cassette do
      it 'names the file appropriately' do |example|
        result = described_class.new(example).call
        expect(result).to match(/\A\/cassette_name_by_example_spec\/NxtVcrHarness::CassetteNameByExample\/call\/when_there_is_a_context\z/)
      end
    end
  end
end