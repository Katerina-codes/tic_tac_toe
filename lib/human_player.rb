class HumanPlayer

  def initialize(input_output)
    @input_output = input_output
  end

  def play_move(player_mark, current_grid)
    @input_output.get_move
  end

  def get_valid_move(current_grid, player_mark, converter_instance)
     grid = Grid.new
     @input_output.ask_for_move
     move = play_move(player_mark, current_grid)
     converted_move = converter_instance.convert_move_number(move)
     until grid.move_valid?(move) && grid.is_move_unique?(converted_move, current_grid)
       @input_output.display_invalid_move_error
       move = play_move(player_mark, current_grid)
       converted_move = converter_instance.convert_move_number(move)
     end
     move
   end

end
