class Game

  def initialize(input_output, validator, grid)
    @input_output = input_output
    @validator = validator
    @grid = grid
  end

  def get_player_mark
    @input_output.ask_for_mark_choice
    @input_output.get_mark_choice
  end

  def get_valid_mark(mark)
    until @validator.mark_move_valid?(mark)
      @input_output.ask_for_mark_choice
      mark = @input_output.get_mark_choice
    end
    mark
  end

  def get_player_move
    @input_output.ask_for_move
    @input_output.get_move
  end

  def get_valid_move(move)
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

end
