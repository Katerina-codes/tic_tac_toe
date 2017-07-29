require_relative 'lib/game'
require_relative 'lib/input_output'
require_relative 'lib/validator'
require_relative 'lib/grid'
require_relative 'lib/converter'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

new_game = Game.new(InputOutput.new, Validator.new, Grid.new, Converter.new, HumanPlayer.new, ComputerPlayer.new)
new_game.game_flow
