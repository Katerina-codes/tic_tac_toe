class Game

  def initialize(input_output, validator)
    @input_output = input_output
    @validator = validator
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
    if @validator.move_valid?(move)
      move
    end
  end

end
