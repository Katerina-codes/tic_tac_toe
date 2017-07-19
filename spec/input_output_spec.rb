require 'input_output'

RSpec.describe InputOutput do
  it "displays a formatted grid of numbers 1 - 9 to the user" do
    input_output = InputOutput.new
    expect(input_output.display_grid([["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])).to eq("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
  end
end
