class Game

  def initialize(input_output)
    @input_output = input_output
  end

  def get_player_mark
    @input_output.ask_for_mark_choice
    @input_output.get_mark_choice
  end

end
