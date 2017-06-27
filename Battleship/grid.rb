require_relative 'grid_coordinates'
require_relative 'ship'

class Grid
    attr_reader :grid 
    attr_reader :h
    attr_reader :size
    attr_reader :row_num_for_alpha
    attr_reader :alpha_arr
    def initialize size
        @alpha_arr = ('a'..'j').to_a
        @row_num_for_alpha = 0
        @size = size
        @grid = Array.new(size){Array.new(size)}
        @h = self.grid_hash
    end
    def grid_hash
        h = Hash.new
        for n in @alpha_arr
            if @row_num_for_alpha > @size - 1
                break
            end
            h[n] = @row_num_for_alpha
            @row_num_for_alpha += 1
        end
        h
    end
    def [] gc
        if @h[gc.row]
            @grid[@h[gc.row]][gc.col.to_i]
        else
            false
        end
    end
    def []= gc, val
        if @h[gc.row]
            @grid[@h[gc.row]][gc.col.to_i] = val
        else
            false
        end
    end
    def to_s
        for n in (0...@grid.size)
            @grid[n][0] = (@h.keys[n])
        end
        col_names = (0...@grid.size).to_a.map { |i| i.to_s.rjust(2) }.join
        matrix = @grid.map { |a| a.map { |i| i.to_s.rjust(2) }.join }
        
        "  " + col_names + "\n" + matrix.join("\n")
    end
    def place_ship ship, coord
        #needed in case user tries to use a nonsensical coordinate
        if @h[coord.row] && coord.col.to_i <= @size && coord.col.to_i >= 0
            self[coord] = ship
        else
            false
        end
    end
    def coordinate_path gc, ship, direction
        path_arr = []
        if direction == "U" || direction == "u"
            for n in (0...ship.size)
                path_arr.push(GridCoordinates.new("#{(gc.row.ord - n).chr}#{gc.col}"))
            end
        elsif direction == "D" || direction == "d"
            for n in (0...ship.size)
                path_arr.push(GridCoordinates.new("#{(gc.row.ord + n).chr}#{gc.col}"))
            end
        end
        path_arr
    end
    def incr gc, direction, ship
        error_message = "You can't place your ship there!"
        case direction
        when "L", "l"
            for n in (0...ship.size)
                if self[GridCoordinates.new("#{gc.row}#{gc.col - n}")]
                    puts error_message
                    return false
                end
            end
            if (gc.col.to_i - ship.size) < 0
                    puts error_message
                    return false
            else
                for n in (0...ship.size)
                    self.place_ship ship, GridCoordinates.new("#{gc.row}#{gc.col - n}")
                end
            end
        when "R", "r"
            for n in (0...ship.size)
                if self[GridCoordinates.new("#{gc.row}#{gc.col + n}")]
                    puts error_message
                    return false
                end
            end
            if (gc.col.to_i + ship.size) > @size
                    puts error_message
                    return false
            else
                for n in (0...ship.size)
                    self.place_ship ship, GridCoordinates.new("#{gc.row}#{gc.col + n}")
                end
            end
        when "U", "u"
            path_arr = coordinate_path(gc, ship, "U")
            for n in path_arr
                if self[n] != nil
                    puts error_message
                    return false
                end
            end
            if !(@h[(gc.row.ord - ship.size).chr])
                    puts error_message
                    return false
            else
                for n in (0...ship.size)
                    self.place_ship ship, GridCoordinates.new("#{(gc.row.ord - n).chr}#{gc.col}")
                end
            end
        when "D", "d"
            path_arr = coordinate_path(gc, ship, "D")
            for n in path_arr
                if self[n] != nil
                    puts error_message
                    return false
                end
            end
            if !(@h[(gc.row.ord + ship.size).chr])
                    puts error_message
                    return false
            else
                for n in (0...ship.size)
                    self.place_ship ship, GridCoordinates.new("#{(gc.row.ord + n).chr}#{gc.col}")
                end
            end
        end
    end
end
