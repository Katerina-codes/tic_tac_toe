require 'converter'

RSpec.describe Converter do

  it "converts 1 to [0, 0]" do
    converter = Converter.new
    expect(converter.convert_move_number(1)).to eq([0, 0])
  end

end
