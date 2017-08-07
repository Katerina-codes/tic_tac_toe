class Game

  def initialize(input_output, validator, grid, converter, human_player, computer_player)
    @input_output = input_output
    @validator = validator
    @grid = grid
    @converter = converter
    @human_player = human_player
    @computer_player = computer_player
  end

  def get_valid_mark
    @input_output.ask_for_mark_choice
    mark = @input_output.get_mark_choice
    until @validator.mark_move_valid?(mark)
      @input_output.ask_for_mark_choice
      mark = @input_output.get_mark_choice
    end
    mark
  end

  def get_valid_move(current_grid, player_type, move_sequences, player_mark)
    @input_output.ask_for_move
    move = player_type.play_move(move_sequences, player_mark)
    converted_move = @converter.convert_move_number(move)
    until @validator.move_valid?(move) && @grid.is_move_unique?(converted_move, current_grid)
      @input_output.display_invalid_move_error
      move = player_type.play_move(move_sequences, player_mark)
      converted_move = @converter.convert_move_number(move)
    end
    move
  end

  def initial_grid
    new_grid = @grid.draw_grid
    @input_output.display_grid(new_grid)
    new_grid
  end

  def display_latest_move_on_grid(mark, move, current_grid)
    formatted_mark = @converter.get_mark_template(move, mark)
    converted_move = @converter.convert_move_number(move)
    @grid.place_a_move(current_grid, converted_move, formatted_mark)
  end

  def get_winning_hits(winning_move_sequences, move, player_mark)
    winning_moves = winning_move_sequences.flatten
    index_position_of_move = (0..winning_moves.length-1).select { |value| winning_moves[value] == move }
    index_position_of_move.each { |index| winning_moves[index] = player_mark }
    winning_moves.each_slice(3).to_a
  end

  def game_is_over?(winning_move_sequences, winning_sequence)
    !(winning_move_sequences & winning_sequence).empty?
  end

  def get_mark_for_p2(p1_mark)
    if p1_mark == "X"
      "O"
    else
      "X"
    end
  end

  def get_end_score(current_grid)
    if @grid.row_has_three_marks?(current_grid, "X") || @grid.column_has_three_marks?(current_grid, "X") || @grid.diagonal_has_three_marks?(current_grid, "X")
      @input_output.display_player_one_wins
    elsif @grid.row_has_three_marks?(current_grid, "O") || @grid.column_has_three_marks?(current_grid, "O") || @grid.diagonal_has_three_marks?(current_grid, "O")
        @input_output.display_player_two_wins
    else
      @input_output.display_game_tie
    end
  end

  def player_flow(player_type, player_mark, winning_move_sequences, current_grid)
    move = get_valid_move(current_grid, player_type, winning_move_sequences, player_mark)
    display_latest_move_on_grid(player_mark, move, current_grid)
    get_winning_hits(winning_move_sequences, move, player_mark)
  end

  def game_flow
    player_types = {
      1 => [@human_player, @human_player],
      2 => [@human_player, @computer_player]
    }

    winning_move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    p1_winning_move_sequence = [["X", "X", "X"]]
    p2_winning_move_sequence = [["O", "O", "O"]]
    @input_output.ask_for_game_mode
    game_mode = @input_output.get_game_mode
    current_grid = initial_grid
    p1_mark = "X"
    p2_mark = "O"
    p1_type, p2_type = player_types[game_mode]

    until game_is_over?(winning_move_sequences, p1_winning_move_sequence) || game_is_over?(winning_move_sequences, p2_winning_move_sequence)
      winning_move_sequences = player_flow(p1_type, p1_mark, winning_move_sequences, current_grid)
      if game_is_over?(winning_move_sequences, p1_winning_move_sequence)
        return @input_output.display_grid(current_grid)
      else
        @input_output.display_grid(current_grid)
        winning_move_sequences = player_flow(p2_type, p2_mark, winning_move_sequences, current_grid)
        @input_output.display_grid(current_grid)
      end
    end
  end

end
