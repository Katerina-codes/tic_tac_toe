class Validator

  def move_valid?(move)
    move > 0 && move < 10
  end

  def mark_move_valid?(mark)
    true
  end

end
