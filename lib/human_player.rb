class HumanPlayer

  def initialize(input_output, grid)
    @input_output = input_output
    @grid = grid
  end

  def get_valid_move(current_grid, player_mark)
    @input_output.ask_for_move
    move = play_move(player_mark, current_grid)
    until @grid.move_valid?(move) && @grid.move_unique?(move - 1, current_grid)
      @input_output.display_invalid_move_error
      move = play_move(player_mark, current_grid)
    end
    move
  end

  private

  def play_move(player_mark, current_grid)
    @input_output.get_move
  end

end
