require "../grid_coordinates.rb"
require "../grid.rb"
require "../ship.rb"
require "test/unit"

class TestGrid < Test::Unit::TestCase
    def test_constructor
        my_grid = Grid.new 5
        expected_size = 5
        assert_equal(expected_size, my_grid.size)
        
        assert_equal(5, my_grid.row_num_for_alpha)
        
        expected_hash = {"a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4}
        assert_equal(expected_hash, my_grid.h)
        
        expected_alpha_arr = ("a".."j").to_a
        assert_equal(expected_alpha_arr, my_grid.alpha_arr)
    end
    def test_grid_hash
        my_grid = Grid.new 5
        dummy_hash = {"a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4}
        assert_equal(dummy_hash, my_grid.h)
    end
    def test_grid_reader
        my_grid = Grid.new 5
        nil_grid = Array.new(5){Array.new(5)}
        assert_equal(nil_grid, my_grid.grid)
    end
    def test_square_brackets
        my_grid = Grid.new 5
        my_gc   = GridCoordinates.new "A3"
        nil_arr = Array.new(5)
        assert_equal(nil, my_grid[my_gc])
    end
    def test_square_brackets_equal
        my_grid = Grid.new 5
        my_gc   = GridCoordinates.new "A3"
        my_grid[my_gc] = 20
        assert_equal(20, my_grid[my_gc])
    end
    def test_to_s
        my_grid = Grid.new 2
        my_gc = GridCoordinates.new "A1"
        expected_grid = [["a", nil], ["b", nil] ].map { |a| a.map { |i| i.to_s.rjust(2) }.join }.join("\n")
        expected_col = [0, 1].map { |i| i.to_s.rjust(2) }.join
        expected_out = "  " + expected_col + "\n" + expected_grid
        assert_equal(expected_out, my_grid.to_s)
    end
    def test_place_ship
        my_grid = Grid.new 5
        my_gc = GridCoordinates.new "A9"
        ship = Ship.new 2
        my_grid.place_ship(ship, my_gc)
        assert_equal(false, my_grid.place_ship(ship, my_gc))
        assert_equal(nil, my_grid[my_gc])
    end
    def test_increment_L
        my_grid = Grid.new 5
        too_big_gc = GridCoordinates.new "A9"
        too_small_gc = GridCoordinates.new "A0"
        ship = Ship.new 2
        
        my_grid.incr(too_small_gc, "L", ship)
        assert_equal(nil, my_grid[too_small_gc])
        
        my_grid.incr(too_big_gc, "L", ship)
        assert_equal(nil, my_grid[too_big_gc])
        
    end
    def test_increment_R
        my_grid = Grid.new 5
        too_big_gc = GridCoordinates.new "A5"
        ship = Ship.new 2
        
        my_grid.incr(too_big_gc, "R", ship)
        assert_equal(nil, my_grid[too_big_gc])
    end
    def test_increment_U
        my_grid = Grid.new 5
        too_small_gc = GridCoordinates.new "A3"
        destroyer = Ship.new 2
        
        cruiser = Ship.new 3
        another_small_gc = GridCoordinates.new "B3"
        my_grid.incr(another_small_gc, "U", cruiser)
        assert_equal(nil, my_grid[another_small_gc])
        
        my_grid.incr(too_small_gc, "U", destroyer)
        assert_equal(nil, my_grid[too_small_gc])
        
    end
    def test_increment_D
        my_grid = Grid.new 5
        too_large_gc = GridCoordinates.new "E3"
        ship = Ship.new 2
        
        my_grid.incr(too_large_gc, "D", ship)
        assert_equal(false, my_grid.incr(too_large_gc, "D", ship))
        assert_equal(nil, my_grid[too_large_gc])
        
    end
    def test_collision
        my_grid = Grid.new 5
        cruiser = Ship.new 3
        cruiser_gc = GridCoordinates.new "C4"
        cruiser_direction = "L"
        
        destroyer = Ship.new 2
        destroyer_gc = GridCoordinates.new "D3"
        destroyer_direction = "U"
        
        my_grid.incr(cruiser_gc, cruiser_direction, cruiser)
        my_grid.incr(destroyer_gc, destroyer_direction, destroyer)
        assert_equal(nil, my_grid[destroyer_gc])
    end
end
