class Validator

  def move_valid?(move)
    move > 0 && move < 10
  end

end
