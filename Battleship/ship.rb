class Ship
    attr_reader :size
    attr_accessor :hits
    def initialize size = 2
        @size = size
        @hits = 0
    end
    def to_s
        " "
    end
    def is_sunk?
        @hits == size
    end
end
