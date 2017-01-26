# /spec/bow_spec.rb
require 'weapons/bow'

describe Bow do

  let(:bow){Bow.new}

  describe '#initialize' do
    it "A Bow's arrow count is readable" do
      expect(bow).to respond_to :arrows
    end

    it "A Bow starts with 10 arrows by default" do
      expect(bow.arrows).to eq(10)
    end

    it "A Bow created with a specified number of arrows starts with that number of arrows" do
      starting_bows = 3
      bow_3 = Bow.new(3)
      expect(bow_3.arrows).to eq(3)
    end
  end

  describe 'using a bow' do
    it 'use ing a Bow reduces arrows by 1' do
      bow_4 = Bow.new(4)
      bow_4.use
      expect(bow_4.arrows).to eq(3)
    end
  end

  describe 'using a bow with no arrows' do
    it 'useing a Bow with 0 arrows throws an error' do
      bow_empty = Bow.new(0)
      expect{bow_empty.use}.to raise_error("Out of arrows")
    end
  end
end
