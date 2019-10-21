RSpec.describe NxtVcrHarness do
  it "has a version number" do
    expect(NxtVcrHarness::VERSION).not_to be nil
  end

  subject do
    Class.new do
      extend NxtVcrHarness::VcrCassetteHelper
    end
  end

  describe '.hash_from_example' do
    it 'creates a hash from the example' do |example|
      hash = subject.hash_from_example(example)
      expect(hash).to match(/[a-z0-9]{32}/)
    end
  end
end
