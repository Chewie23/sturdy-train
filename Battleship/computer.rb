require_relative 'player'
require_relative 'ship'
class Computer < Player
    def suppress_output
        begin
            original_stderr = $stderr.clone
            original_stdout = $stdout.clone
            $stderr.reopen(File.new('nul', 'w'))
            $stdout.reopen(File.new('nul', 'w'))
            retval = yield
        rescue Exception => e
            $stdout.reopen(original_stdout)
            $stderr.reopen(original_stderr)
            raise e
        ensure
            $stdout.reopen(original_stdout)
            $stderr.reopen(original_stderr)
        end
        retval
    end
    def rand_gc
        gc_string = []
        gc_choices = []
        for n in (0..9)
            gc_string.push("#{("a".."j").to_a.shuffle[n]}#{(0...self.board.size).to_a.shuffle[n]}")
        end
        for n in gc_string
            gc_choices.push(GridCoordinates.new(n))
        end
        gc_choices.shuffle.pop
    end
    def rand_direction
        ["U", "D", "L", "R"].shuffle.pop
    end
    def ship_placement
        for name in @ship_hash.keys
            until suppress_output{board.incr(self.rand_gc, self.rand_direction, @ship_hash[name])}
            end
        end
    end
    def fire other
        rand_gc = self.rand_gc
        if miss?(other, rand_gc)
            puts "Computer fired at #{rand_gc.row.upcase}#{rand_gc.col} and has missed"
            other.board[rand_gc] = "O"
            return true
        elsif other.board[rand_gc].instance_of? Ship
            puts "Computer fired at #{rand_gc.row.upcase}#{rand_gc.col} and has hit #{other.ship_object_hash[other.board[rand_gc]]}"
            other.board[rand_gc].hits += 1
            if other.board[rand_gc].is_sunk?
                puts "Your #{other.ship_object_hash[other.board[rand_gc]]} has been sunk!"
            end
            other.board[rand_gc] = "*"
            return true
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
end
