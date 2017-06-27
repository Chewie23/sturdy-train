require_relative "computer"
require_relative "player"
require_relative 'grid_coordinates'
require_relative 'grid'
require_relative 'ship'

class Game
    def initialize
        @player = Player.new
        @computer = Computer.new
        @turn = 2
    end
    def main_loop
        while true
            if @turn.even?
                @computer.fire(@player)
                @player.ships_sunk
                @turn += 1
            else
                puts "#{5 - @computer.ships_sunk.size } enemy ships left"
                @player.display_board(@computer)
                @player.fleet_status
                
                puts "Where to fire?"
                print "> "
                user_gc = @player.coordinates
                @player.fire(@computer, user_gc)
                @computer.ships_sunk
                @turn += 1
            end
        end
    end
    def start
        @computer.ship_placement
        @player.ship_placement
        self.main_loop
    end
end

game = Game.new
game.start
