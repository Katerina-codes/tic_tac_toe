require 'validator'

RSpec.describe Validator do

  it "returns true if 1 is entered" do
    validator = Validator.new
    expect(validator.move_valid?(1)).to eq(true)
  end

  it "returns false if 10 is entered" do
    validator = Validator.new
    expect(validator.move_valid?(10)).to eq(false)
  end

  it "returns true if 2 is entered" do
    validator = Validator.new
    expect(validator.move_valid?(2)).to eq(true)
  end

  it "returns true if move equals x" do
    validator = Validator.new
    expect(validator.mark_move_valid?("x")).to eq(true)
  end

  it "returns false if move is not x" do
    validator = Validator.new
    expect(validator.mark_move_valid?("a")).to eq(false)
  end

end
