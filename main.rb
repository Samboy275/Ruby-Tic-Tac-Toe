

# 1 - make a class for board to draw the board in console
class Board
  attr_reader :game_over
  # 1 - class should contain a way of storing board elements
  def initialize
    @board_elements = 9.times.map{|num| num + 1}
  # 2 - board should have states to know the state of the game
    @game_over = false
    @availab_moves = @board_elements.map{|place| place}
  end

  # 3 - class should check for winning conditions
  def won?
    won = false
    @board_elements.each_with_index{ |element, i|
      if (i < 3)
        if (element == @board_elements[i + 3] && element == @board_elements[i + 6])
          won = true
        end
      end
      if (i % 3 == 0)
        if (element == @board_elements[i + 1] && @board_elements[i + 2] ==  element)
          won = true
        end
      end
      if (i == 4)
        if ((element == @board_elements[i - 4] && element == @board_elements[i + 4]) || (element == @board_elements[i -2] && board_elements[i] == @board_elements[i + 2]))
          won = true
        end
      end
      if won
        @game_over = true
      end
    }
    won
  end

  # 4 - should make a function to draw the board with the current elements
  def draw_board
    for i in 3.times
      puts "\n" unless i != 0
      for j in 3.times
        print '|' unless j == 0
        print "  #{@board_elements[j + (i * 3)]}  "
      end
      puts "\n"
      if (i < 2)
        puts '-' * 17
      end
    end
    puts ''
  end

  # 5 - must register player movements
  def move(index, char)
    if !@availab_moves.include?(index)
      return false
    end
    @board_elements[index - 1] = char
    self.won?
    return true
  end
end




board = Board.new
board.draw_board
while !board.game_over
  player_move = gets.chomp.to_i
  while !board.move(player_move, 'x'); end
  board.draw_board
end
