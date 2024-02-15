# frozen_string_literal: true

RSpec.describe NxtVcrHarness::UnneededHeaders do
  describe '#strip' do
    let(:headers_hash) do
      {
        'X-Monty-Python-Life-Of-Brian' => '1979',
        'monty-python-flying-circus' => '1969',
        'X-The-Hobbit' => '2012',
        'x-monty-python-holy-grail' => '1975',
      }
    end

    it 'strips headers by regex' do
      expect(described_class.strip(headers_hash, [/(X-)?Monty-Python-*/i])).to eq({
        'X-The-Hobbit' => '2012',
      })
    end

    it 'strips headers by string' do
      expect(described_class.strip(headers_hash, ['x-Monty-Python-holy-grail'])).to eq({
        'X-Monty-Python-Life-Of-Brian' => '1979',
        'monty-python-flying-circus' => '1969',
        'X-The-Hobbit' => '2012',
      })
    end

    it 'strips headers by string and regex' do
      expect(described_class.strip(headers_hash, ['x-monty-python-holy-grail', /hobbit/i])).to eq({
        'X-Monty-Python-Life-Of-Brian' => '1979',
        'monty-python-flying-circus' => '1969',
      })
    end

    it 'raises an error for an unknown key type' do
      expect { described_class.strip(headers_hash, [55]) }.to raise_error(ArgumentError)
    end
  end
end
