require 'validator'

RSpec.describe Validator do

  it "only allows a number from 1 - 9 to be entered" do
    validator = Validator.new
    expect(validator.move_valid?(1)).to eq(true)
  end
end
