require_relative 'lib/game'
require_relative 'lib/input_output'
require_relative 'lib/validator'
require_relative 'lib/grid'

new_game = Game.new(InputOutput.new, Validator.new, Grid.new)
new_game.get_player_mark
