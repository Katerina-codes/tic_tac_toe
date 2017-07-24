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

  def get_valid_move
    @input_output.ask_for_move
    move = @input_output.get_move
    until @validator.move_valid?(move)
      @input_output.ask_for_move
      move = @input_output.get_move
    end
    move
  end

  def initial_grid
    new_grid = @grid.draw_grid
    @input_output.display_grid(new_grid)
  end

  def get_move_and_update_grid(mark, current_grid)
    move = get_valid_move
    formatted_mark = @converter.get_mark_template(move, mark)
    converted_move = @converter.convert_move_number(move)
    @grid.place_a_move(current_grid, converted_move, formatted_mark)
  end

  def game_flow
    new_grid = @grid.draw_grid
    @input_output.display_grid(new_grid)
    mark = get_valid_mark
    current_grid = new_grid

    until current_grid == [["| #{mark} ", "| #{mark} |", " #{mark} |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      current_grid = get_move_and_update_grid(mark, new_grid)
    end
    @input_output.display_grid(current_grid)
  end

end
