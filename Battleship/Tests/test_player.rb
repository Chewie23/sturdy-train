require "../player.rb"
require "test/unit"

class TestPlayer < Test::Unit::TestCase
    def test_size_default_constructor
        player = Player.new
        assert_equal(10, player.board.size)
        assert_equal(2, player.destroyer.size)
        assert_equal({:Destroyer=>player.destroyer, :Submarine=>player.submarine, :Cruiser=>player.cruiser, :Battleship=>player.battleship, :Carrier=>player.carrier},
                                player.ship_hash)
    end
    def test_ship_coordinates
        player = Player.new
        user_placement = "A3L"
        gc, dir = player.process_ship_coordinates(user_placement)
        assert_equal("L", dir)
        assert_equal("a", gc.row)
        assert_equal(4, gc.col)
    end
    def test_process_coordinates
        player = Player.new
        user_placement = "A3"
        gc = player.process_coordinates(user_placement)
        assert_equal("a", gc.row)
        assert_equal(4, gc.col)
    end
    
end
