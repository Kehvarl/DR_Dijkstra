# Main.RB
# Primary file checked by Dragon Ruby
# Load all class and setup files first, and `Tick.RB` last.

# Load classes here
require 'lib/dijkstra.rb'
require 'app/game.rb'
require 'app/entity.rb'


# Do this last so you know all your classes are loaded before the game starts
require 'app/tick.rb'
