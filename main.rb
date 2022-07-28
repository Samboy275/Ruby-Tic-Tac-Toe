# frozen_string_literal: true

# 1 - make a class for board to draw the board in console
class Board
  attr_reader :game_over

  # 1 - class should contain a way of storing board elements
  def initialize
    @board_elements = 9.times.map { |num| num + 1 }
    # 2 - board should have states to know the state of the game
    @game_over = false
    @availab_moves = @board_elements.map { |place| place }
  end

  # 3 - class should check for winning conditions
  def check_rows?
    [0, 3, 6].each do |i|
      return true if @board_elements[i] == @board_elements[i + 1] && @board_elements[i] == @board_elements[i + 2]
    end
    false
  end

  def check_columns?
    3.times.each do |i|
      return true if @board_elements[i] == @board_elements[i + 3] && @board_elements[i] == @board_elements[i + 6]
    end
    false
  end

  def check_intersection?
    return true if @board_elements[4] == @board_elements[0] && @board_elements[4] == @board_elements[8]

    return true if @board_elements[4] == @board_elements[2] && @board_elements[4] == @board_elements[6]

    false
  end

  def won?
    won = check_columns? || check_intersection? || check_rows?
    @game_over = true if won
    won
  end

  # 4 - should make a function to draw the board with the current elements
  def draw_board
    3.times.each do |i|
      puts "\n" unless i != 0
      3.times.each do |j|
        print '|' unless j.zero?
        print "  #{@board_elements[j + (i * 3)]}  "
      end
      puts "\n"
      puts '-' * 17 if i < 2
    end
    puts ''
  end

  # 5 - must register player movements
  def move(index, char)
    return false unless @availab_moves.include?(index)

    @board_elements[index - 1] = char
    won?
    true
  end
end

board = Board.new
board.draw_board
until board.game_over
  player_move = gets.chomp.to_i
  until board.move(player_move, 'x'); end
  board.draw_board
end
