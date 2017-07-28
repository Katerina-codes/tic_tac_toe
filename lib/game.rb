class Game

  def initialize(input_output, validator, grid, converter)
    @input_output = input_output
    @validator = validator
    @grid = grid
    @converter = converter
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

  def get_valid_move(current_grid)
    @input_output.ask_for_move
    move = @input_output.get_move
    converted_move = @converter.convert_move_number(move)
    until @validator.move_valid?(move) && @grid.is_move_unique?(converted_move, current_grid)
      @input_output.display_invalid_move_error
      move = @input_output.get_move
      converted_move = @converter.convert_move_number(move)
    end
    move
  end

  def initial_grid
    new_grid = @grid.draw_grid
    @input_output.display_grid(new_grid)
  end

  def display_latest_move_on_grid(mark, move, current_grid)
    formatted_mark = @converter.get_mark_template(move, mark)
    converted_move = @converter.convert_move_number(move)
    @grid.place_a_move(current_grid, converted_move, formatted_mark)
  end

  def get_winning_hits(winning_move_sequences, move)
    winning_moves = winning_move_sequences.flatten
    index_position_of_move = (0..winning_moves.length-1).select { |value| winning_moves[value] == move }
    index_position_of_move.each { |index| winning_moves[index] = "marked_move" }
    winning_moves.each_slice(3).to_a
  end

  def game_is_won?(winning_move_sequences, winning_sequence)
    !(winning_move_sequences & winning_sequence).empty?
  end

  def get_mark_for_p2(p1_mark)
    if p1_mark == "X"
      "O"
    else
      "X"
    end
  end

  def game_flow
    p1_winning_move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    p2_winning_move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    winning_sequence = [["marked_move", "marked_move", "marked_move"]]
    @input_output.ask_for_game_mode
    @input_output.get_game_mode
    current_grid = @grid.draw_grid
    @input_output.display_grid(current_grid)
    p1_mark = get_valid_mark
    p2_mark = get_valid_mark

    until game_is_won?(p1_winning_move_sequences, winning_sequence) || game_is_won?(p2_winning_move_sequences, winning_sequence)
      p1_move = get_valid_move(current_grid)
      p1_winning_move_sequences = get_winning_hits(p1_winning_move_sequences, p1_move)
      update_grid_with_p1_move = display_latest_move_on_grid(p1_mark, p1_move, current_grid)
      if game_is_won?(p1_winning_move_sequences, winning_sequence)
        return @input_output.display_grid(current_grid)
      else
        @input_output.display_grid(current_grid)
        p2_move = get_valid_move(current_grid)
        p2_winning_move_sequences = get_winning_hits(p2_winning_move_sequences, p2_move)
        update_grid_with_p2_move = display_latest_move_on_grid(p2_mark, p2_move, current_grid)
        @input_output.display_grid(current_grid)
      end
    end
  end

end
