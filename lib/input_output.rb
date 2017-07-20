class InputOutput

  def initialize(output = $stdout, input = $stdout)
    @output = output
    @input = input
  end

  def display_grid(grid)
    row_lines = " --- --- ---"
    formatted_grid = grid.map do |each_row|
      row_lines + "\n" + each_row.join("") + "\n"
    end

    @output.puts "\n"
    @output.puts formatted_grid
    @output.print row_lines
  end

  def ask_for_mark_choice
    @output.puts "Choose your mark, type 'X' or 'O'"
  end

  def ask_for_move
    @output.puts "Time to place your mark! Please choose a number from 1 - 9"
  end

  def get_move
    @input.gets.to_i
  end

end
