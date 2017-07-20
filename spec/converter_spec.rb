require 'converter'

RSpec.describe Converter do

  it "converts 1 to [0, 0]" do
    converter = Converter.new
    expect(converter.convert_move_number(1)).to eq([0, 0])
  end

  it "converts 2 to [0, 1]" do
    converter = Converter.new
    expect(converter.convert_move_number(2)).to eq([0, 1])
  end

end
