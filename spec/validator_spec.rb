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

end
