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

  def get_move_and_update_grid(mark, move, current_grid)
    formatted_mark = @converter.get_mark_template(move, mark)
    converted_move = @converter.convert_move_number(move)
    @grid.place_a_move(current_grid, converted_move, formatted_mark)
  end

  def get_winning_hits(winning_moves, move)
    winning_moves = winning_moves.flatten
    index_position_of_move = (0..winning_moves.length-1).select { |value| winning_moves[value] == move }
    index_position_of_move.each { |index| winning_moves[index] = "marked_move" }
    winning_moves.each_slice(3).to_a
  end

  def game_is_won?(winning_move_sequences, winning_sequence)
    !(winning_move_sequences & winning_sequence).empty?
  end

  def game_flow
    winning_move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    winning_sequence = [["marked_move", "marked_move", "marked_move"]]

    current_grid = @grid.draw_grid
    @input_output.display_grid(current_grid)
    mark = get_valid_mark

    until game_is_won?(winning_move_sequences, winning_sequence)
      move = get_valid_move(current_grid)
      winning_move_sequences = get_winning_hits(winning_move_sequences, move)
      current_grid = get_move_and_update_grid(mark, move, current_grid)
      @input_output.display_grid(current_grid)
    end
    @input_output.display_grid(current_grid)
  end

end
