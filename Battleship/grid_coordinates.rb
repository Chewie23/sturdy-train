#Have to add "1" to the column because the way we print out the grid, we are actually adding an element to the array
#Thus pushing the index back
class GridCoordinates
    attr_accessor :row
    attr_accessor :col
    def initialize string
        @row = string[0].downcase
        @col = string[1].to_i + 1
    end
end
