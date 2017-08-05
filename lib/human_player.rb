class HumanPlayer

  def initialize(input_output)
    @input_output = input_output
  end

  def play_move(move_sequences, player_mark)
    @input_output.get_move
  end

end
