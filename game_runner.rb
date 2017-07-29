require_relative 'lib/game'
require_relative 'lib/input_output'
require_relative 'lib/validator'
require_relative 'lib/grid'
require_relative 'lib/converter'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

input_output_instance = InputOutput.new
new_game = Game.new(input_output_instance, Validator.new, Grid.new, Converter.new, HumanPlayer.new(input_output_instance), ComputerPlayer.new)
new_game.game_flow
