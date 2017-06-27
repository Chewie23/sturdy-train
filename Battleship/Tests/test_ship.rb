require "../ship.rb"
require "test/unit"

class TestShip < Test::Unit::TestCase
    def test_size_default_constructor
        ship = Ship.new
        assert_equal(2, ship.size)
    end
    def test_hits_constructor
        ship = Ship.new 
        assert_equal(0, ship.hits)
    end
    def test_size_constructor
        ship = Ship.new 5
        assert_equal(5, ship.size)
    end
    def test_hits_accessor
        ship = Ship.new

        #Testing getter
        assert_equal(0, ship.hits)

        #Testing setter
        ship.hits = 3
        assert_equal(3, ship.hits)
    end
    def test_to_s
        ship = Ship.new
        assert_equal(" ", ship.to_s)
    end
    def test_is_sunk?
        ship = Ship.new
        assert_equal(false, ship.is_sunk?)
        
        other_ship = Ship.new 3
        
        other_ship.hits = 2
        assert_equal(false, other_ship.is_sunk?)
         
        other_ship.hits += 1
        assert_equal(true, other_ship.is_sunk?)
    end
end
