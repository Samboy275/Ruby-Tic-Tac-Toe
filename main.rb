

# 1 - make a class for board to draw the board in console
class Board
  attr_reader :game_over
  # 1 - class should contain a way of storing board elements
  def initialize
    @board_elements = 9.times.map{|num| num}
    @game_over = false
    @availab_moves = @board_elements.map{|place| place}
  end
  # 2 - class should check for winning conditions
  # 3 - board should have states to know the state of the game
  # 4 - should make a function to draw the board with the current elements
  def draw_board
    for i in 3.times
      puts "\n" unless i != 0
      for j in 3.times
        print '|' unless j == 0
        print "  #{@board_elements[j + (i * 3)] + 1}  "
      end
      puts "\n"
      if (i < 2)
        puts '-' * 17
      end
    end
    puts ''
  end
  # 5 - must register player movements
end




board = Board.new



board.draw_board
