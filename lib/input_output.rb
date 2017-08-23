class InputOutput

  def initialize(output = $stdout, input = $stdin)
    @output = output
    @input = input
  end

  def display_grid(current_grid)
    one, two, three, four, five, six, seven, eight, nine = current_grid
    @output.puts "\n --- --- ---"
    @output.puts "| #{one} | #{two} | #{three} |"
    @output.puts " --- --- ---"
    @output.puts "| #{four} | #{five} | #{six} |"
    @output.puts " --- --- ---"
    @output.puts "| #{seven} | #{eight} | #{nine} |"
    @output.puts " --- --- ---"
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
    until input == 1 || input == 2
      display_game_mode_input_error
      input = get_game_mode
    end
    input
  end

  def display_game_mode_input_error
    @output.puts "That game mode is invalid. Please enter 1 or 2."
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

  def ask_for_replay
    @output.puts "Do you want to play again?\nEnter '1' for yes or '2' for no."
  end

  def display_replay_input_error
    @output.puts "Please enter 1 or 2."
  end

  def get_valid_replay_decision
    input = @input.gets.to_i
    until input == 1 || input == 2
      display_replay_input_error
      input = @input.gets.to_i
    end
    input
  end

end
