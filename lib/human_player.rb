class HumanPlayer

  def initialize(input_output = InputOutput.new)
    @input_output = input_output
  end

  def play_move
    @input_output.get_move
  end

end
