# /spec/warmup_spec.rb
require 'warmup'

describe Warmup do
  let(:warmup){Warmup.new}
  let(:arr) {Array.new(2)}

  describe 'gets_shout' do
    it 'returns the input uppercase' do
      # allow(user).to receive(:name)

      allow(warmup).to receive(:gets).and_return("hello")
      expect(warmup.gets_shout).to eq("HELLO")
    end
  end

  describe 'triple_size' do
    it 'triples the size of the existing element' do
      expect(warmup.triple_size(arr)).to eq(6)
    end
  end
end