require "../grid_coordinates.rb"
require "test/unit"

class TestGC < Test::Unit::TestCase
    def test_constructor
        #Should this be for accessors? Or do I keep it this way and don't have
        #to test accessors?
        my_gc = GridCoordinates.new "A3"
        assert_equal("a", my_gc.row)
        assert_equal("3", my_gc.col)
    end
end
