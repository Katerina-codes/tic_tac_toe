require 'validator'

RSpec.describe Validator do

  let(:validator) { Validator.new }

  context 'Validates player\'s move' do

    it "returns true if 1 is entered" do
      expect(validator.move_valid?(1)).to eq(true)
    end

    it "returns false if 10 is entered" do
      expect(validator.move_valid?(10)).to eq(false)
    end

    it "returns true if 2 is entered" do
      expect(validator.move_valid?(2)).to eq(true)
    end

  end

  context 'Validates player\'s mark' do

    it "returns true if move equals x" do
      expect(validator.mark_move_valid?("x")).to eq(true)
    end

    it "returns false if move is not x" do
      expect(validator.mark_move_valid?("a")).to eq(false)
    end

    it "returns true if move is o" do
      expect(validator.mark_move_valid?("o")).to eq(true)
    end

  end

end
