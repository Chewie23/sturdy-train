class Board
    attr_reader :board, :val
    def initialize board, move = 1, val = 1
        @board = Array.new(board.size){|i| i == (move - 1) ? val : board[i]}.freeze
        
        @winning_state = [[1, 2, 3], [4, 5, 6], [7, 8, 9], #Horizontal
                          [1, 4, 7], [2, 5, 8], [3, 6, 9], #Vertical
                          [1, 5, 9], [3, 5, 7]].freeze     #Diagonals
        @val = val.freeze
    end
    def size
        @board.size
    end
    def [](idx)
        @board[idx]
    end
    def win_state?
        return @winning_state.any? { |line| line.all? { |idx| @board[idx - 1] == @val } }
    end
    def cats_game?
        return !(@board.any?{|n| n.is_a? Numeric})
    end
    def valid_move turn
        print "#{turn} to move (1..9): "
        move = gets.chomp
        if (move.to_i.between?(1,9)) && (@board[move.to_i - 1].is_a? Numeric)
            return move.to_i
        end
        puts "Invalid move!"
        self.to_s
        valid_move turn
    end
    def to_s
        @board.each_with_index.map {|e, i| 
            if i % 3 == 2
                puts("#{e}\n---------")
            else 
                print("#{e} |")
            end }
    end
end


def exec(board, turn)    
    board.to_s
    if board.win_state?
        puts "#{board.val} Wins!"
        return
    elsif board.cats_game?
        puts "Cat's Game!"
        return
    end
    move = board.valid_move(turn)
    
    if turn  == "X"
        exec(Board.new(board, move, "X"), "O")
    else
        exec(Board.new(board, move, "O"), "X")
    end
end

exec(Board.new((Array.new(9){|x| x + 1})), "O")
