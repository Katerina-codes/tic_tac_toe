class InputOutput

  def initialize(output = $stdout, input = $stdout)
    @output = output
    @input = input
  end

  def display_grid(grid)
    "\n --- --- ---\n| 1 | 2 | 3 |\n --- --- ---\n| 4 | 5 | 6 |\n --- --- ---\n| 7 | 8 | 9 |\n --- --- ---"
  end

  def ask_for_move
    @output.puts "Time to place your mark! Please choose a number from 1 - 9"
  end

  def get_move
    @input.gets.to_i
  end

end
