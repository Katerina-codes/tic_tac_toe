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

  it "converts 3 to [0, 2]" do
    converter = Converter.new
    expect(converter.convert_move_number(3)).to eq([0, 2])
  end

  it "converts 4 to [1, 0]" do
    converter = Converter.new
    expect(converter.convert_move_number(4)).to eq([1, 0])
  end

end
