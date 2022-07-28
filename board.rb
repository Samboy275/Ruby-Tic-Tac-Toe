# frozen_string_literal: true

# make a class for board to draw the board in console
class Board
  attr_reader :game_over, :availab_moves

  # class should contain a way of storing board elements
  def initialize
    @board_elements = 9.times.map { |num| num + 1 }
    # board should have states to know the state of the game
    @game_over = false
    @availab_moves = @board_elements.map { |place| place }
  end

  def won?
    won = check_columns? || check_intersection? || check_rows?
    @game_over = true if won
    won
  end

  # should make a function to draw the board with the current elements
  def draw
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

  # must register player movements
  def move(index, char)
    # require "pry-byebug"; binding.pry
    return false unless @availab_moves.include?(index)

    @availab_moves.delete(index)
    @game_over = true if any_moves_left?
    @board_elements[index - 1] = char
    won?
    true
  end

  private

  # class should check for winning conditions
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

  def any_moves_left?
    return true if @availab_moves.length.zero?

    false
  end
end
