class InputOutput

  def initialize(output = $stdout, input = $stdin)
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
    @output.puts row_lines
  end

  def ask_for_mark_choice
    @output.puts "Choose your mark, type 'X' or 'O'"
  end

  def get_mark_choice
    @input.gets.chomp.upcase
  end

  def ask_for_move
    @output.puts "Time to place your mark! Please choose a number from 1 - 9"
  end

  def get_move
    @input.gets.to_i
  end

  def display_invalid_move_error
    @output.puts "This move is invalid. Please enter another one"
  end

  def ask_for_game_mode
    @output.puts "Please choose a mode:\nEnter '1' for human vs human\nEnter '2' for human vs computer\n"
  end

  def get_game_mode
    @input.gets.chomp.to_i
  end

  def get_valid_game_mode_input
    input = get_game_mode
    if input == 1 || input == 2
      input
    else
      @output.puts "That game mode is invalid. Please enter 1 or 2."
    end
  end

  def display_player_one_wins
    @output.puts "Game over. Player 1 wins!"
  end

  def display_player_two_wins
    @output.puts "Game over. Player 2 wins!"
  end

  def display_game_tie
    @output.puts "Game over. It's a tie!"
  end

end
