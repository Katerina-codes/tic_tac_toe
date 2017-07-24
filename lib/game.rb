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
      @input_output.ask_for_move
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

  def game_flow
    winning_moves = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    previous_moves = []

    new_grid = @grid.draw_grid
    @input_output.display_grid(new_grid)
    mark = get_valid_mark
    current_grid = new_grid
    until !(winning_moves & [previous_moves]).empty?
      move = get_valid_move(current_grid)
      previous_moves.push(move)
      current_grid = get_move_and_update_grid(mark, move, new_grid)
    end
    @input_output.display_grid(current_grid)
  end

end
