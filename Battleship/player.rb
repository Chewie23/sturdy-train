require_relative 'grid_coordinates'
require_relative 'grid'
require_relative 'ship'

class Player
    attr_reader :board
    attr_accessor :destroyer
    attr_accessor :submarine
    attr_accessor :cruiser
    attr_accessor :battleship
    attr_accessor :carrier
    attr_reader :ship_object_hash
    attr_reader :ship_hash
    def initialize size_of_grid = 10
        @board = Grid.new size_of_grid
        @destroyer = Ship.new 2
        @submarine = Ship.new 3
        @cruiser = Ship.new 3
        @battleship = Ship.new 4
        @carrier = Ship.new 5
        @ship_hash = {:Destroyer=>@destroyer, :Submarine=>@submarine, :Cruiser=>@cruiser, :Battleship=>@battleship, :Carrier=>@carrier}
        @ship_object_hash = {@destroyer=>:Destroyer, @submarine=>:Submarine,@cruiser=> :Cruiser, @battleship=>:Battleship, @carrier=>:Carrier}
    end
    def coordinates
        user_placement = gets.chomp
        GridCoordinates.new(user_placement)
    end
    def process_coordinates(user_placement)
        GridCoordinates.new(user_placement)
    end
    def ship_coordinates
        user_placement = gets.chomp
        direction = user_placement[2]
        user_gc = GridCoordinates.new(user_placement[0..1])
        
        [user_gc, direction]
    end
    def process_ship_coordinates(user_placement)
        direction = user_placement[2]
        user_gc = GridCoordinates.new(user_placement[0..1])
        
        [user_gc, direction]
    end
    def ship_placement
        #Not very defensive. Assumes user knows correct commands
        for name in @ship_hash.keys
            puts "Where do you want to put your #{name}?"
            print "> "
            user_gc, direction = ship_coordinates
            until board.incr user_gc, direction, @ship_hash[name]
                puts "Where do you want to put your #{name}?"
                print "> "
                user_gc, direction = ship_coordinates
            end
        end
    end
    def miss?(other, gc)
        other.board[gc] == nil || other.board[gc] == "O" || other.board[gc] == "*"
    end
    def fire other, gc
        if miss?(other, gc)
            puts "Firing at #{gc.row.upcase}#{gc.col - 1}...Missed!"
            other.board[gc] = "O"
        elsif other.board[gc].instance_of? Ship
            puts "Firing at #{gc.row.upcase}#{gc.col - 1}...Hit!"
            other.board[gc].hits += 1
            if other.board[gc].is_sunk?
                puts "Enemy #{other.ship_object_hash[other.board[gc]]} has been sunk!"
            end
            other.board[gc] = "*"
        end
        true
    end
    def fleet_status
        puts "Your fleet's status:"
        for name in @ship_hash.keys
            if @ship_hash[name].is_sunk?
                puts "#{name} \t Sunk"
            else
                puts "#{name} \t #{@ship_hash[name].hits} hit(s)"
            end
        end
    end
    def ships_sunk
        @ships_sunk = []
        for name in @ship_hash.keys
            if @ship_hash[name].is_sunk?
                @ships_sunk.push(name)
            end
        end
        @ships_sunk
    end
    def display_board other
        puts other.board.to_s
    end
end
